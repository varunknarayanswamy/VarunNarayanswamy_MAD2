//
//  weatherInfo.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/7/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation

struct weather: Decodable {
    var icon: String
    var summary: String
    var temperature:Float
    var windSpeed:Float
}
