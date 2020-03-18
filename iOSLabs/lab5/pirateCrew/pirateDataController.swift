//
//  pirateDataController.swift
//  pirateCrew
//
//  Created by Varun Narayanswamy on 3/14/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation
import Firebase

struct pirate {
    var date: Date
    var name: String
    var position: String
    var id: String
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

class pirateDataController {
    var db: Firestore!
    //store data locally
    var pirateData = [pirate]()
    //notify view controller
    var onDataUpdate: (([pirate])-> Void)!
    init() {
        //default settings
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
    
    func loadData()
    {
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID{
            db.collection("users").document(userID).collection("pirateMembers").addSnapshotListener({QuerySnapshot, error in
                guard let collection = QuerySnapshot else {
                    print("error fetching collection: \(error!)")
                    return
                }
                //get all the documents in the collection
                let docs = collection.documents
                
                //empty current data
                self.pirateData.removeAll()
                
                for doc in docs{
                    let data = doc.data()
                    let date = (data["Date"]  as! Timestamp).dateValue()
                    
                    let name = data["name"] as! String
                    
                    let position = data["position"] as! String
                    
                    let id = doc.documentID
                    
                    let newPirate  = pirate(date: date, name: name, position: position, id: id)
                    self.pirateData.append(newPirate)
                }
                print(self.pirateData)
                
                self.onDataUpdate(self.pirateData)
            })
        } else{
            print("You done messed up")
        }
        
    }
    
    func writeData(date:Date, name:String,position:String){
        
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID{
            db.collection("users").document(userID).collection("pirateMembers").addDocument(data:[
                "Date": Timestamp(date: date),
                "name": name,
                "position": position
            ])
        }
    }
    
}

