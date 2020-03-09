//
//  addItemCell.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/5/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class addItemCell: UITableViewCell, UITextFieldDelegate {
    
    var tableInfo = Int()

    @IBOutlet weak var addItemcell: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addItemcell.text = ""
        addItemcell.delegate = self
        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func addItem(_ sender: Any) {
        if (addItemcell.text?.isEmpty != true){
            print("in here")
            let tableInfoHashable: [String: String] = ["tableInfo": String(tableInfo), "textInfo":addItemcell.text!]
        var newNotfication = Notification.init(name: Notification.Name(rawValue: "addPressed"))
        newNotfication.userInfo = tableInfoHashable
        NotificationCenter.default.post(newNotfication)
        }
    }
}
