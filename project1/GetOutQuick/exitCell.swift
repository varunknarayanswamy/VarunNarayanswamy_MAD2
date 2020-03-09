//
//  exitCell.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/5/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class exitCell: UITableViewCell {
    
    var arrayIndex = Int()

    @IBOutlet weak var exitTime: UILabel!
    @IBOutlet weak var exitName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func exitOnOff(_ sender: Any) {
        GlobalClass.globalItems.exitTimeArray[arrayIndex].on.toggle()
    }
    
}
