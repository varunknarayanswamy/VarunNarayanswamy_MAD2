//
//  pokemonType.swift
//  Pokédex
//
//  Created by Varun Narayanswamy on 2/17/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import Foundation
import UIKit

struct PokemonDataModel: Codable {
    var PokemonType: String
    var Pokemon: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
}

class PokemonDataController {
    var allData = [PokemonDataModel]()
    let filename = "pokedex"
    let dataFileName = "data.plist"
    
    init() {
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(PokemonDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    func getDataFile(dataFile: String) -> URL {
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0]
        return docDir.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        let dataFileUrl = getDataFile(dataFile: dataFileName)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileUrl)
        }catch{
            print(error)
            throw DataError.CouldNotDecode
        }
    }
    
    func loadData() throws {
        let pathUrl: URL?
        let dataFileUrl = getDataFile(dataFile: dataFileName)
        if FileManager.default.fileExists(atPath: dataFileUrl.path)
        {
            print("exists")
            pathUrl = dataFileUrl
        }
        else{
            print("doesn't exist")
            pathUrl = Bundle.main.url(forResource: filename, withExtension: "plist")
        }

        if let dataUrl = pathUrl{
            print("dataURl")
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: dataUrl)
                allData = try decoder.decode([PokemonDataModel].self, from: data)
            }
            catch{
                throw DataError.CouldNotDecode
            }
        }
        else{
                throw DataError.NoDataFile
        }
    }
    
    func getType() -> [String]{
        print("getType Data")
        var allTypes = [String]()
        
        for items in allData{
            allTypes.append(items.PokemonType)
        }
        print(allTypes)
        return allTypes
    }
    
    func getPokemon(idx: Int)->[String]{
        return allData[idx].Pokemon
    }
    
    func addPokemon(dataIdx: Int, newPokemon: String, typeIdx: Int){
        allData[dataIdx].Pokemon.insert(newPokemon, at: typeIdx)
    }
    
    func deletePokemon(dataIdx: Int, typeIdx: Int){
        allData[dataIdx].Pokemon.remove(at: typeIdx)
    }
}

