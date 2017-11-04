//
//  String+Extensions.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation

extension String {
    var isEmptyOrWhitespace : Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}
