//
//  detailViewController.swift
//  WeatherAPI
//
//  Created by Varun Narayanswamy on 2/29/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    var iconInfo = String()
    var temp = Float()
    var sum = String()
    var wind = Float()


    @IBOutlet weak var WeatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(iconInfo)
        chooseImage(icon: iconInfo)
        tempLabel.text = "\(temp) °F"
        precipitationLabel.text = sum
        WindSpeed.text = "\(wind) mph"
    }
    
    func chooseImage(icon: String){
        switch icon {
        case "clear-day":
            WeatherImage.image = UIImage(named: "clearDay")
        case "clear-night":
            WeatherImage.image = UIImage(named: "clearNight")
        case "rain":
            WeatherImage.image = UIImage(named: "rain")
        case "snow":
            WeatherImage.image = UIImage(named: "snow")
        case "sleet":
            WeatherImage.image = UIImage(named: "sleet")
        case "wind":
            WeatherImage.image = UIImage(named: "wind")
        case "fog":
            WeatherImage.image = UIImage(named: "fog")
        case "cloudy":
            WeatherImage.image = UIImage(named: "cloudy")
        case "partly-cloudy-day":
            WeatherImage.image = UIImage(named: "partlyCloudyDay")
        case "partly-cloudy-night":
            WeatherImage.image = UIImage(named: "partlyCloudyNight")
        default:
            WeatherImage.image = UIImage(named: "snow")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
