//
//  ViewController.swift
//  Pokédex
//
//  Created by Varun Narayanswamy on 2/17/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var typeDataController = PokemonDataController()
    var typeList = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try typeDataController.loadData()
            typeList = typeDataController.getType()
               } catch{
                   print(error)
               }
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        cell.textLabel?.text = typeList[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TypePokemon" {
            print("this segue")
            let detailVC = segue.destination as! PokemonViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            if let selection = indexPath?.row {
                detailVC.selectedType = selection
                detailVC.title = typeList[selection]
                detailVC.typeController = typeDataController
            }
        }else if segue.identifier == "TypeInfo" {
            let infoVC = segue.destination as! TypeInfoViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            infoVC.type = typeList[indexPath!.row]
            
            let pokemonList = typeDataController.getPokemon(idx: indexPath!.row)
            print(pokemonList)
            infoVC.number = String(pokemonList.count)
            infoVC.title  = typeList[indexPath!.row]
        }
    }
}
