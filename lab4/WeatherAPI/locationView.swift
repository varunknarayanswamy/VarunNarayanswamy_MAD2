//
//  locationView.swift
//  WeatherAPI
//
//  Created by Varun Narayanswamy on 2/29/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit

class locationView: UITableViewController {
    
    var weatherAPI = weatherAPIControl()
    var locations = [locationInfo]()
    
    var data = weather(icon: "",summary: "",temperature: 0.0,windSpeed: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLocations()
        weatherAPI.onDataUpdate = {[weak self](data: weather) in self!.searchDone(weather: data)}
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchDone(weather: weather){
        print("dismiss")
        data = weather
        performSegue(withIdentifier: "Locationweather", sender: nil)
    }
    
    func buildLocations(){
        let location1 = locationInfo(name: "Boulder", lat: "40.0150", long: "105.2705")
        let location2 = locationInfo(name: "San Jose", lat: "37.3382", long: "121.8863")
        let location3 = locationInfo(name: "Orlando", lat: "28.5383", long: "81.3792")
        let location4 = locationInfo(name: "Madrid", lat: "40.4168", long: "3.7038")
        let location5 = locationInfo(name: "Delhi", lat: "28.7041", long: "77.1025")
        let location6 = locationInfo(name: "Beijing", lat: "39.9042", long: "116.4074")
        let location7 = locationInfo(name: "Tokyo", lat: "35.6762", long: "139.6503")
        let location8 = locationInfo(name: "London", lat: "51.5074", long: "0.1278")
        let location9 = locationInfo(name: "Washington D.C.", lat: "38.9072", long: "77.0369")
        let location10 = locationInfo(name: "Alaska", lat: "64.2008", long: "149.4937")
        let locationsChosen = [location1,location2,location3,location4,location5,location6,location7,location8,location9,location10]
        locations = locationsChosen
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Locationweather"{
            let detailVC = segue.destination as! detailViewController
                detailVC.iconInfo = data.icon
                detailVC.sum = data.summary
                detailVC.temp = data.temperature
                detailVC.wind = data.windSpeed
           }
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherAPI.getAPICall(lat: locations[indexPath.row].lat, long: locations[indexPath.row].long)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   

}
