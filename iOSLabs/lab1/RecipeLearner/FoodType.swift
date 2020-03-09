//
//  FoodType.swift
//  RecipeLearner
//
//  Created by Varun Narayanswamy on 2/3/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation

struct FoodType: Decodable {
    let Cuisine: String
    let Foods: [String]
}
