//
//  exitTimeViewcontroller.swift
//  GetOutQuick
//
//  Created by Varun Narayanswamy on 3/5/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//
import MapKit
import UIKit

class exitTimeViewcontroller: UIViewController, UITextFieldDelegate {

    var oldName = ""
    var indexNum = Int()
    var timer = Timer()
    var oldTime = Date()
    var oldTimeIncrementType = Int()
    var oldTimeIncrements = ""
    var oldItems = [String]()
    var specificItemArray = [String]()
    var generalItemArray = [String]()
    let addNotfication = Notification.Name(rawValue: "addPressed")
    @IBOutlet weak var exitTimeName: UITextField!
    @IBOutlet weak var exitTimeTime: UIDatePicker!
    @IBOutlet weak var notificationTime: UITextField!
    @IBOutlet weak var minuteOrHour: UISegmentedControl!
    @IBOutlet weak var specificItemsTableview: UITableView!
    @IBOutlet weak var generalItemsTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        exitTimeName.delegate = self
        notificationTime.delegate = self
        if (oldName != "")
        {
            print("newitem")
            exitTimeName.text = oldName
            exitTimeTime.date = oldTime
            minuteOrHour.selectedSegmentIndex = oldTimeIncrementType
            notificationTime.text = oldTimeIncrements
            specificItemArray = oldItems
        }
        NotificationCenter.default.addObserver(self, selector: #selector(addItem(_:)), name: addNotfication, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
        
    @objc func addItem(_ notification:Notification){
        if let userInfo = notification.userInfo{
            let tableNum = userInfo["tableInfo"] as? String
            let addedString = userInfo["textInfo"] as? String
            let tableNumInt = Int(tableNum!)
            print(tableNumInt!)
            if tableNumInt == 0{
                specificItemArray.append(addedString!)
                specificItemsTableview.reloadData()
            }
            else{
                generalItemArray.append(addedString!)
                generalItemsTableview.reloadData()
            }
        }
    }
        
    @objc func checkTime(timer: Timer)
    {
        guard let context = timer.userInfo as? [String: Int] else { return }
        let num = context["timerInfo"]
        if (timer != nil)
        {
            if (timer.fireDate == GlobalClass.globalItems.exitTimeArray[num!].alarmTime)
            {
                let timeContext = ["time": num]
                var newNotification = Notification(name: Notification.Name(rawValue: "leave"))
                newNotification.userInfo = timeContext
                NotificationCenter.default.post(newNotification)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "save"){
            if (exitTimeName.text?.isEmpty != true && notificationTime.text?.isEmpty != true){
                return true
            }
            else
            {
                let alert = UIAlertController(title: "Missing components", message: "make sure you add in info for the name of the exit time and the notification tim ", preferredStyle: .alert)
                present(alert, animated: true, completion: nil)
                let done  = UIAlertAction(title: "Done", style: .default, handler: { [unowned alert] _ in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(done)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "save")
        {
            if (exitTimeName.text?.isEmpty != true && notificationTime.text?.isEmpty != true)
            {
                var date2 = Date()
                if (minuteOrHour.selectedSegmentIndex == 0){
                    date2 = exitTimeTime.date.addingTimeInterval(TimeInterval(-60*Int(notificationTime.text!)!))
                }
                else{
                    date2 = exitTimeTime.date.addingTimeInterval(TimeInterval(-3600*Int(notificationTime.text!)!))
                }
                if (oldName == ""){
                    let context = ["timerInfo": GlobalClass.globalItems.exitTimeArray.count]
                    timer = Timer(fireAt: date2, interval: 0, target: self, selector: #selector(checkTime), userInfo: context, repeats: false)
                    RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
                    let newExitTime = GlobalClass.exitTimes(name: exitTimeName.text!, alarmTime: date2, exitTime: exitTimeTime.date, notificationTime: Int(notificationTime.text!)!, notifificationType: minuteOrHour.selectedSegmentIndex, specificItems: specificItemArray, on: true)
                    GlobalClass.globalItems.exitTimeArray.append(newExitTime)
                    GlobalClass.generalInfo.generalItems = generalItemArray
                }
                else{
                    let context = ["timerInfo": indexNum]
                    timer = Timer(fireAt: exitTimeTime.date, interval: 0, target: self, selector: #selector(checkTime), userInfo: context, repeats: false)
                    RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
                    print("huh?")
                    GlobalClass.globalItems.exitTimeArray[indexNum].alarmTime = date2
                    GlobalClass.globalItems.exitTimeArray[indexNum].name = exitTimeName.text!
                    GlobalClass.globalItems.exitTimeArray[indexNum].exitTime = exitTimeTime.date
                    GlobalClass.globalItems.exitTimeArray[indexNum].specificItems =  specificItemArray
                    GlobalClass.globalItems.exitTimeArray[indexNum].notificationTime = Int(notificationTime.text!)!
                    GlobalClass.globalItems.exitTimeArray[indexNum].notifificationType = minuteOrHour.selectedSegmentIndex
                    GlobalClass.generalInfo.generalItems = generalItemArray
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

extension exitTimeViewcontroller: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == specificItemsTableview)
        {
            return specificItemArray.count+1
        }
        else{
            return generalItemArray.count+1
        }

    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == specificItemsTableview)
        {
            if (indexPath.row != specificItemArray.count){
                let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
                cell.textLabel?.text = specificItemArray[indexPath.row]
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addItem", for: indexPath) as! addItemCell
                cell.tableInfo = 0
                return cell
            }
        }
        else{
            if (indexPath.row != generalItemArray.count){
                let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
                cell.textLabel?.text = generalItemArray[indexPath.row]
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "addItem", for: indexPath) as! addItemCell
                cell.tableInfo = 1
                return cell
            }
        }
    }
}
