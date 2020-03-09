//
//  dataModel.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/5/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation

class GlobalClass{
    struct globalItems{
        static var exitTimeArray = [exitTimes]()
    }
    struct exitTimes {
        var name: String
        var alarmTime: Date
        var exitTime: Date
        var notificationTime: Int
        var notifificationType: Int
        var specificItems = [String]()
        var on: Bool
    }
    struct generalInfo {
        static var generalItems = [String]()
    }
}
