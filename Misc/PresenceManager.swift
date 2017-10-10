////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

// This is a little ugly,but CLLocationManager needs both permissions to run (i.e. get the user's locaton),
// and updates its data asynchronously which makes it very unpredictable to use from a lot of classes.
//
// In general this app only needs approximate locations and only needs them to either update map objects
// or update location objects which drive the overall app's presence reporting mechanism.
//
// Rather than pass around a reference to the CLLocation manager and have to keep resetting it's delegate, this tiny
// singleton is provided whose sole job is to listen for postition change notications and make the last-known location
// available.


import Foundation
import UIKit
import CoreLocation
import RealmSwift


enum PresenceManagerStatus{
    case notauthorized  // the user hasn't allowed us to access their location
    case uninitialized  // user has authed, but locationmanager has yet to return 1st position
    case running        // we're running, will update location as necessary
    case paused         // for some reason cllocation has paused locaton updates (usally poor GPS signal)
    case stopped        // cllocation manager updates have been stopped
}




@objc class PresenceManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = PresenceManager()
    
    var locationManager: CLLocationManager?
    var currentState:PresenceManagerStatus = .uninitialized
    var lastLocation: CLLocationCoordinate2D?
    var lastLocationName = ""       // every time we get a coordinate, reverse it to a human readable name
    var lastUpdatedAt: Date?
    var continuousUpdateMode = true
    var updateInterval = 30         // how often we should call the delegate registered with us
    var identity: String?
    
    var tokensToSkipOnUpdate = [NotificationToken]()
    
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
            self.start(realmIdentity: nil)
        }
    }
    
    
    // MARK: RLMLittleLocationManager Methods
    
    // allows a caller to try to start receiving updates - only used if the user enables AllowLocation{Always|WhenInUse}
    func start(realmIdentity: String?) {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        // so this is a little belt and suspenders work here - CLLocationManager takes time
        // to warm up and get locations, so we start this mamager as soon as the app starts,
        // however the user might not yet be logged in.  So, if we're not passed the current user's
        // ID here. we see if it was set by some other controller that uses us.
        if realmIdentity != nil && self.identity == nil {
            self.identity = realmIdentity!
            print("PresenceManager: Setting identity to \(String(describing: self.identity))")
        } else {
            print("PresenceManager: Starting - but identity was nil")
        }
        
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager!.startUpdatingLocation()
        } else {
            print("continuous mode on, but not CLLocation authorization")
        }
        self.currentState = .running
    }
    
    
    
    // if for some odd reason you need to stop the service -- should never really be needed
    // I.e., if the user goes into prefs and turns off the location permission, location updates are
    // turned off automatically.)
    func stop() {
        if continuousUpdateMode == true {
            locationManager!.stopUpdatingLocation()
        }
        currentState = .stopped
    }
    
    
    func lastKnownLocation() -> (lastLocation: CLLocationCoordinate2D?, near: String?, at: Date? ) {
        // this is the default in case CLLocationManager isn't running or not allowed
        if currentState == .uninitialized || currentState == .notauthorized  {
            return (nil, nil, nil)
        }
        return (lastLocation, lastLocationName, lastUpdatedAt)
    }
    
    func state() -> PresenceManagerStatus {
        return self.currentState
    }
    
    
    // MARK: CLLocationManagerDelegate Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last?.coordinate
        
        lastUpdatedAt = Date()
        
        if self.identity != nil {
           // self.updatePresenceForIdentity(identity: self.identity)
        } else {
            print("PresenceManager: tried to update presence, but identity was nil")
        }
        
    }
    
    internal func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        lastLocation!.latitude = (manager.location?.coordinate.latitude)!
        lastLocation!.longitude = (manager.location?.coordinate.longitude)!
        currentState = .running
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("PresenceManager: location failed with error: \(error.localizedDescription)")
    }
    
    
    internal func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        currentState = .paused
        print("PresenceManager: location updates paused at \(NSDate())")
    }
    
    
    @nonobjc internal func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            currentState = .notauthorized
            print ("PresenceManager: didChangeAuthorizationStatus to \(status)")
        case .restricted:
            print ("PresenceManager: didChangeAuthorizationStatus to \(status)")
        case .denied:
            print ("PresenceManager: didChangeAuthorizationStatus to \(status)")
            currentState = .notauthorized
            stop()
        case .authorizedAlways,
             .authorizedWhenInUse:
            print ("PresenceManager: didChangeAuthorizationStatus to \(status)")
            currentState = .running
            start(realmIdentity: nil)
        }
    }
    
    
    func reverseGeocodeForLocation(location: CLLocation) -> String {
        var rv = ""
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("PresenceManager: Reverse geocoder failed with error - " + error!.localizedDescription)
                return
            }
            /* - CLPlacemark field names:
             name                       // eg. Apple Inc.
             thoroughfare               // street name, eg. Infinite Loop
             subThoroughfare            // eg. 1
             locality                   // city, eg. Cupertino
             subLocality                // neighborhood, common name, eg. Mission District
             administrativeArea         // state, eg. CA
             subAdministrativeArea      // county, eg. Santa Clara
             postalCode                 // zip code, eg. 95014
             ISOcountryCode             // eg. US
             country                    // eg. United States
             inlandWater                // eg. Lake Tahoe
             ocean                      // eg. Pacific Ocean
             */
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                rv = "\(String(describing: pm?.locality!)), \(String(describing: pm?.administrativeArea!)) "
            }
        })
        return rv
    }
    
    
    
}
