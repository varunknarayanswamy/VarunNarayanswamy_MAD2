//
//  weatherAPIController.swift
//  WeatherAPI
//
//  Created by Varun Narayanswamy on 2/29/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation

class weatherAPIControl{
    
    var currentWeather = weather(icon: "",summary: "",temperature: 0.0,windSpeed: 0.0)
    
    var onDataUpdate: ((_ data: weather)-> Void)?
    
    func getAPICall(lat:String, long:String)
    {
        let baseURL = "https://api.darksky.net/forecast/ce2116bd279d2b222b6221af35eda885/\(lat),\(long)"
        guard let url = URL(string: baseURL) else {
            print("bad url")
            return
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
        
            let statusCode = httpResponse.statusCode
            
            guard statusCode == 200 else {
                print("file download error: \(statusCode)")
                return
            }
            print("download complete!")
            DispatchQueue.main.async {
                self.parseJson(rawData: data!)
            }
        })
        session.resume()
    }
    
    func parseJson(rawData: Data){
        let json = try? JSONSerialization.jsonObject(with: rawData, options: [])
        if let jsonversion = json as? NSDictionary{
            if let info = jsonversion["currently"] as? NSDictionary{
                    currentWeather.summary = info.value(forKey: "summary") as! String
                    currentWeather.temperature = Float(truncating: info.value(forKey: "temperature") as! NSNumber)
                    currentWeather.windSpeed = Float(truncating: info.value(forKey: "windSpeed") as! NSNumber)
                    currentWeather.icon = info.value(forKey: "icon") as! String
                    onDataUpdate?(currentWeather)
            }
        }
    }
}
