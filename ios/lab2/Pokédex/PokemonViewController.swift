//
//  PokemonViewController.swift
//  Pokédex
//
//  Created by Varun Narayanswamy on 2/17/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class PokemonViewController: UITableViewController {
    
    var selectedType = 0
    var typeController = PokemonDataController()
    var pokemonList = [String]()
    
    var searchControl = UISearchController()
    
    override func viewWillAppear(_ animated: Bool) { //called every time
        pokemonList = typeController.getPokemon(idx: selectedType)
        let resultsController = searchController()
        resultsController.allPokemon = pokemonList
        
        searchControl = UISearchController(searchResultsController: resultsController)
        searchControl.searchBar.placeholder = "Filter"
        searchControl.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchControl.searchBar
        searchControl.searchResultsUpdater = resultsController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if segue.identifier == "save" {
            print("true")
            let source = segue.source as! AddPokemon
            print(source.AddedPok)
            if source.AddedPok.isEmpty == false {
                typeController.addPokemon(dataIdx: selectedType, newPokemon: source.AddedPok, typeIdx: selectedType)
            }
            pokemonList.append(source.AddedPok)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemonList[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //notify model
            typeController.deletePokemon(dataIdx: selectedType, typeIdx: indexPath.row)
            //update local copy
            pokemonList.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let fromRow = fromIndexPath.row
        let toRow = to.row
        
        let movePokemon = pokemonList[fromRow]
        pokemonList.swapAt(fromRow, toRow)
        //notify data controller
        typeController.deletePokemon(dataIdx: selectedType, typeIdx: fromRow)
        typeController.addPokemon(dataIdx: selectedType, newPokemon: movePokemon, typeIdx: toRow)

    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
