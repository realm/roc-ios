//
//  MimeType.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation

enum MimeType : String {
    case textPlain = "text/plain"
    case textMarkdown = "text/markdown"
    case imageJPEG = "image/jpeg"
    case imageGIF = "image/gif"
    case imagePNG = "image/png"

    /// This is a helper to remind you to attempt to load a URL
    var isImage : Bool {
        return self == .imageGIF
            || self == .imageJPEG
            || self == .imagePNG
    }
}
