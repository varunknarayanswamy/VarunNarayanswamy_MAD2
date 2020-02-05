//
//  FoodBuild.swift
//  RecipeLearner
//
//  Created by Varun Narayanswamy on 2/3/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation

//define our error types
enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class FoodBuild {
    //class properties
    var FoodData: [FoodType]?
    let filename = "Recipe"
    
    //load all the data from our plist and throw appropriate errors if we run into issues
    func loadData() throws {
        print("Loading data....")
        //get our file based on the file path
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            let decoder = PropertyListDecoder()
            do {
                //get file contents
                let data = try Data(contentsOf: pathURL)
                print(data)
                print("data")
                //decode them using our struct as the type to decode to
                FoodData = try decoder.decode([FoodType].self, from: data)
                print("Data loaded")
            } catch {
                print("didn't work")
                throw DataError.CouldNotDecodeData
            }
        }
            //error fetching data file
        else {
            throw DataError.BadFilePath
        }
    }
    
    //put cuisines in an array or throw error for not having the data
    func getCuisines() throws -> [String] {
        var cuisine = [String]()
        //make sure we got data
        if let data = FoodData {
            for foodType in data {
                cuisine.append(foodType.Cuisine)
            }
            print("worked")
            return cuisine
        }
        else {
            //we don't have data!
            print("didn't work")
            throw DataError.NoData
        }
        
        
    }

    //get the foods for each cuisine and populate array or return error
    func getFoods(idx: Int) throws -> [String] {
        if let data = FoodData {
            return data[idx].Foods
        }
        else {
            //we don't have data!
            throw DataError.NoData
        }
    }
}

