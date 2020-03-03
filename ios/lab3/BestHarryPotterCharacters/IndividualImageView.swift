//
//  IndividualImageView.swift
//  BestHarryPotterCharacters
//
//  Created by Varun Narayanswamy on 2/29/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class IndividualImageView: UIViewController {
    
    var imageName : String?

    @IBOutlet weak var largerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareImage(_ sender: Any) {
        var imageArray = [UIImage]()
        
        imageArray.append(largerImage.image!)
        
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        
        shareScreen.modalPresentationStyle = .popover
        present(shareScreen, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = imageName {
            largerImage.image = UIImage(named: name)
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
