//
//  AddPokemon.swift
//  Pokédex
//
//  Created by Varun Narayanswamy on 2/17/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class AddPokemon: UIViewController {
    var AddedPok =  String()
    @IBOutlet weak var addedPokemonEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "save"){
            if addedPokemonEditText.text?.isEmpty == false{
                AddedPok = addedPokemonEditText.text!
                print(AddedPok)
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
