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


// Some methods (PDF resizing) based on work orignally implemented in Objective-C by Erica Sadun

import Foundation
import UIKit

extension UIImage {
    
    func scaleToSize(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height)) // Draw the scaled image in the current context
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext() // Create a new image from current context
        UIGraphicsEndImageContext() // Pop the current context from the stack
        return scaledImage!         // Return our new scaled image
    }
    
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
        }
        
        let rect = CGRect(x:0, y:0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    // returns a an image sized to fit within a rectangle of the given size (preserving aspect ratio)
    // as a side-benefit, any exif orientation is flattened & applied
    func normalizedImageWithMaxiumSize( maximumSize : CGFloat) -> UIImage  {
        // how big should the dest image be?
        let srcSize = self.size
        var destSize : CGSize
        // don't scale the src image up, either!
        
        if srcSize.height > srcSize.width { // portrait
            // don't *enlarge* the source image
            var maxHeight = maximumSize
            if maxHeight > srcSize.height {
                maxHeight = srcSize.height
            }
            
            destSize = CGSize(width: maxHeight *  srcSize.width / srcSize.height, height: maxHeight )
        } else { // landscape orientation (width constrained)
            // don't *enlarge* the source image
            var maxWidth = maximumSize
            if maxWidth > srcSize.width {
                maxWidth = srcSize.width
            }
            
            destSize = CGSize(width: maxWidth, height: maxWidth * srcSize.height/srcSize.width )
        }
        
        // draw into the destination image
        UIGraphicsBeginImageContextWithOptions( destSize, true/*opaque?*/, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: destSize.width, height: destSize.height))
        
        // get the dest image out
        let destImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return destImage!
    }

}
