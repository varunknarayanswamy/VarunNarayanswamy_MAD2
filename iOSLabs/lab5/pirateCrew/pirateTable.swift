//
//  pirateTable.swift
//  
//
//  Created by Varun Narayanswamy on 3/14/20.
//

import UIKit

class pirateTable: UITableViewController {
    
    var dc = pirateDataController()
    
    var pirateData = [pirate]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dc.onDataUpdate = {[weak self](data: [pirate]) -> Void in
            self?.newData(data: data)}
        
        dc.loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func newData(data: [pirate])
    {
        pirateData = data
        pirateData.sort(by:{(r1,r2) in r1.date.compare(r2.date) == .orderedDescending})
        tableView.reloadData()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier == "save"{
            let source = segue.source as! addPirate
            dc.writeData(date: source.date ?? Date(), name: source.name ?? "", position: source.position ?? "")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pirateData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pirateCell", for: indexPath)
        
        let pirate = pirateData[indexPath.row]
        
        cell.textLabel?.text = pirate.name
        cell.detailTextLabel?.text = pirate.position

        // Configure the cell...

        return cell
    }

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
