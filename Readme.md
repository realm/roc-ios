## RChat, a mobile chat powered by RealmChat

Special thanks to Chatto project for doing incredible work on the UI side of things

## Requirements to Build

You'll need **cococapods**
Install cocoapods with `$ sudo gem install cocoapods`

1. clone this repository `git clone https://github.com/mbalex99/rchat`
2. go to the directory `$ cd rchat`
3. run `pod install`
4. open the workspace `open RChat.xcworkspace`

## Pointing to the Correct Server

Go to the file `RChatConstants.swift` and replace **both** the urls for:

```swift
static var objectServerEndpoint : URL {
    return URL(string: "realm://138.197.85.79:9080" )!
}


static var authServerEndpoint : URL {
    return URL(string: "http://138.197.85.79:9080" )!
}
```


## Regarding 3rd Party Image Upload with AWS S3

You'll need a property list in the project directory `RChat/thirdparty.plist`

The contents should look like this: 

Replace the BLAHBLAHCognitoApplicationIdBLAHBLAH with your AWSCognitoApplicationId. Make sure the application pool id is anonymous or has the right credentials
Replace the BLAHBLAHMyBucketNameBLAHBLAH with your AWS S3 BucketName

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>S3</key>
    <dict/>
        <key>CognitoApplicationId</key>
        <string>BLAHBLAHCognitoApplicationIdBLAHBLAH</string>
        <key>BucketName</key>
        <string>BLAHBLAHMyBucketNameBLAHBLAH</string>
    </dict>
</plist>
```
