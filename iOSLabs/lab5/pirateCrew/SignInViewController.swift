//
//  SignInViewController.swift
//  pirateCrew
//
//  Created by Varun Narayanswamy on 3/14/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController, FUIAuthDelegate {
    
    let authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()

        authUI?.delegate = self
        
        let provider : [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        
        authUI?.providers = provider
    }
    
    @IBAction func login(_ sender: Any) {
        let authViewController  = authUI?.authViewController()
        
        present(authViewController!, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
         if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "rootNav")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
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

