//
//  TimeSeperatorModel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import UIKit
import Chatto

class TimeSeparatorModel: ChatItemProtocol {
    let uid: String
    let type: String = TimeSeparatorModel.chatItemType
    let date: String

    static var chatItemType: ChatItemType {
        return "TimeSeparatorModel"
    }

    init(uid: String, date: String) {
        self.date = date
        self.uid = uid
    }
}

extension Date {
    // Have a time stamp formatter to avoid keep creating new ones. This improves performance
    private static let weekdayAndDateStampDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "EEE MMM dd" // "Monday, Mar 7 2016"
        return dateFormatter
    }()

    func toWeekDayAndDateString() -> String {
        return Date.weekdayAndDateStampDateFormatter.string(from: self)
    }
}
