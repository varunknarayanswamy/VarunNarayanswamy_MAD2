//
//  FirstViewController.swift
//  RecipeLearner
//
//  Created by Varun Narayanswamy on 2/3/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let cuisineComp = 0
    let foodComp = 1
    
    @IBOutlet weak var foodPicker: UIPickerView!
    @IBOutlet weak var foodLabel: UILabel!
    
    var foodController = FoodBuild()
    var cuisines = [String]()
    var foods = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try foodController.loadData()
            cuisines = try foodController.getCuisines()
            foods = try foodController.getFoods(idx: 0)
            print(cuisines)
        }
        catch {
            print(error)
        }
        // Do any additional setup after loading the view.
    }


}

extension FirstViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == cuisineComp {
            return cuisines.count
        } else if component == foodComp {
            return foods.count
        } else {
            print("Unregisted Component")
            return -1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == cuisineComp {
            return cuisines[row]
        } else if component == foodComp {
            return foods[row]
        } else {
            print("Unregisted Component")
            return "Unregisted Component"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == cuisineComp {
            //get the new list of albums
            do {
                foods = try foodController.getFoods(idx: row)
            }
            catch {
                print(error)
            }
            //update the album component
            foodPicker.reloadComponent(foodComp)
            //reset the album component to the first row
            foodPicker.selectRow(0, inComponent: foodComp, animated: true)
        }
        
        let cuisine = pickerView.selectedRow(inComponent: cuisineComp)
        let food = pickerView.selectedRow(inComponent: foodComp)
        
        foodLabel.text = "You like \(cuisines[cuisine]). Specifically \(foods[food])"
    }
    
    
}

