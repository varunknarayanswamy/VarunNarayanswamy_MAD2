//
//  getOutTimeTableview.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/5/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit
import MapKit

class getOutTimeTableview: UITableViewController, CLLocationManagerDelegate {
    var timer: Timer?
    var selectedIndex = 0
    var locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()
    let addNotfication = Notification.Name(rawValue: "leave")
    var weatherAPI = weatherAPIControl()
    var data = weather(icon: "",summary: "",temperature: 0.0,windSpeed: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(timeToGo(_:)), name: addNotfication, object: nil)
        weatherAPI.onDataUpdate = {[weak self](data: weather) in self!.searchDone(weather: data)}
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func timeToGo(_ notification: Notification)
    {
        if let data = notification.userInfo
        {
            if let num = data["time"] as? Int{
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm a"
                timeFormatter.amSymbol = "AM"
                timeFormatter.pmSymbol = "PM"
                let TimeFormattedString = "You are leaving at " + (timeFormatter.string(from: GlobalClass.globalItems.exitTimeArray[num].exitTime)) + "."
                print(TimeFormattedString)
                if (GlobalClass.globalItems.exitTimeArray[num].on == true){
                    var specificItems = "some new items "
                    var globalItems = "Make sure you have your normal stuff, your "
                    if (GlobalClass.globalItems.exitTimeArray[num].specificItems.count != 0){
                        for i in GlobalClass.globalItems.exitTimeArray[num].specificItems
                        {
                            if (i != specificItems)
                            {
                                specificItems = specificItems + i + ", "
                            }
                        }
                    }
                    else{
                        specificItems = "You have no general items, including your"
                    }
                    if (GlobalClass.generalInfo.generalItems.count != 0){
                        for j in GlobalClass.generalInfo.generalItems{
                            if (j != globalItems)
                            {
                                globalItems = globalItems + j + ", "
                            }
                        }
                    }
                    else{
                        globalItems = "you have no specific items for this trip."
                    }
                    let alert = UIAlertController(title: "Time to go!", message: "It's time to go!  \(TimeFormattedString) \(globalItems) and \(specificItems) for this trip.", preferredStyle: .alert)
                    let next  = UIAlertAction(title: "next", style: .default, handler: { [unowned alert] _ in
                        self.weatherAPI.getAPICall(lat: String(format: "%f", self.coordinates.latitude), long: String(format: "%f", self.coordinates.longitude))
                    })
                    alert.addAction(next)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func searchDone(weather: weather){
        data = weather
        var weatherMessage = ""
        switch data.icon {
        case "clear-day":
            weatherMessage = "Today should be nice and clear."
        case "clear-night":
           weatherMessage = "Weather tonight should be nice and clear."
        case "rain":
            weatherMessage = "Weather today is rainy. Make sure to have a rain jacket."
        case "snow":
            weatherMessage = "Weather today is snowy. Make sure to have a winter coat."
        case "sleet":
            weatherMessage = "Weather today will have sleet. Make sure to have a rain jacket."
        case "wind":
            weatherMessage = "Today will be windy. Make sure to have a jacket."
        case "fog":
            weatherMessage = "Today will be foggy. Make sure to have a rain jacket."
        case "cloudy":
            weatherMessage = "Today will be cloudy."
        case "partly-cloudy-day":
            weatherMessage = "Today will be cloudy."
        case "partly-cloudy-night":
            weatherMessage = "Tonight will be cloudy."
        default:
            weatherMessage = "No data on Today."
        }
        if (data.temperature < 40)
        {
            weatherMessage = weatherMessage + " It'll be cold, with a temp of \(data.temperature) degrees. Keep some layers."
        }
        else if (data.temperature < 70)
        {
            weatherMessage = weatherMessage + " Temperature today should be nice at \(data.temperature) degrees!"
        }
        else
        {
            weatherMessage = weatherMessage + " It's going to be hot at \(data.temperature) degrees!"
        }
        let alert = UIAlertController(title: "Weather Today", message: weatherMessage, preferredStyle: .alert)
        let done  = UIAlertAction(title: "Done", style: .default, handler: { [unowned alert] _ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinates = manager.location!.coordinate
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GlobalClass.globalItems.exitTimeArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (GlobalClass.globalItems.exitTimeArray.count != 0)
        {
            let df = DateFormatter()
            df.dateFormat = "MM-dd-yyyy hh:mm a"
            df.amSymbol = "AM"
            df.pmSymbol = "PM"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "exitCell", for: indexPath) as! exitCell
            cell.exitName.text = GlobalClass.globalItems.exitTimeArray[indexPath.row].name
            cell.exitTime.text = df.string(from: GlobalClass.globalItems.exitTimeArray[indexPath.row].exitTime)
            cell.arrayIndex = indexPath.row
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedIndex = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let dest = segue.destination as! exitTimeViewcontroller
        dest.generalItemArray = GlobalClass.generalInfo.generalItems
        if (segue.identifier == "showExit")
        {
            print(GlobalClass.globalItems.exitTimeArray[selectedIndex].name)
            print(selectedIndex)
            dest.oldName = GlobalClass.globalItems.exitTimeArray[selectedIndex].name
            dest.oldTime = GlobalClass.globalItems.exitTimeArray[selectedIndex].exitTime
            dest.oldItems = GlobalClass.globalItems.exitTimeArray[selectedIndex].specificItems
            dest.oldTimeIncrements = String(GlobalClass.globalItems.exitTimeArray[selectedIndex].notificationTime)
            dest.oldTimeIncrementType = GlobalClass.globalItems.exitTimeArray[selectedIndex].notifificationType
            dest.indexNum = selectedIndex
        }
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
