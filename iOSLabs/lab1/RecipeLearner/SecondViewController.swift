//
//  SecondViewController.swift
//  RecipeLearner
//
//  Created by Varun Narayanswamy on 2/3/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

let youtubeScheme = "youtube://"
let chromeyoutube = "http://www.youtube.com"

class SecondViewController: UIViewController {
    
    func openOtherApp(scheme: String) {
      if let url = URL(string: scheme) {
        UIApplication.shared.open(url, options: [:], completionHandler: {
          (success) in
          print("Open \(scheme): \(success)")
        })
      }
    }

    //func for checking if we have access to a given url scheme
    func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    @IBAction func WatchVideo(_ sender: Any) {
        let youtubeAvailable = schemeAvailable(scheme: youtubeScheme)
        if youtubeAvailable{
            openOtherApp(scheme: youtubeScheme)
        }
        else{
            openOtherApp(scheme: chromeyoutube)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

