//
//  addPirate.swift
//  pirateCrew
//
//  Created by Varun Narayanswamy on 3/14/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class addPirate: UIViewController, UITextFieldDelegate, UITextViewDelegate  {

    @IBOutlet weak var pirateAddDate: UIDatePicker!
    @IBOutlet weak var pirateName: UITextField!
    @IBOutlet weak var piratePosition: UITextField!
    
    var name: String?
    var date: Date?
    var position: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(addPirate.didTapView))

        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text:String)-> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func didTapView()
    {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save"{
            if pirateName.text?.isEmpty == false{
                name = pirateName.text 
                date = pirateAddDate.date
                if piratePosition.text!.isEmpty == false
                {
                    position = piratePosition.text
                }
            }
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
