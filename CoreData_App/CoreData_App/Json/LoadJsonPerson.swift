//
//  LoadJsonPerson.swift
//  CoreData_App
//
//  Created by Macbook on 27/03/2023.
//

import Foundation
import UIKit

class LoadJsonPerson: NSObject {
    var personData = [JsonPerson]()
    
    override init(){
        super.init()
        load()
    }
    
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "dataJsons", withExtension: "json"){
            do {
                let data = try Data(contentsOf: fileLocation)
                let dataDeco = JSONDecoder()
                let dataJson = try dataDeco.decode([JsonPerson].self, from: data)
                self.personData = dataJson
            } catch {
                print(error)
            }
        }
        
        //        guard let url = URL(string: "")
        //        else {return}
        //        let dataTask = URLSession.shared.dataTask(with: url) {(data, _, error) in
        //            if let error = error {
        //                print("Erro: \(error.localizedDescription)")
        //            }
        //            guard let jsonData = data else {return}
        //            let decoder = JSONDecoder()
        //
        //            do {
        //                let decodeData = try decoder.decode([JsonPerson].self, from: jsonData)
        //                self.personData = decodeData
        //            }
        //            catch{
        //                print("error")
        //            }
        //        }
        //        dataTask.resume()
        
        //        guard let url = URL(string: "https://raw.githubusercontent.com/programmingwithswift/ReadJSONFileURL/master/hostedDataFile.json")
        //        else {return}
        //        let dataTask = URLSession.shared.dataTask(with: url) {(data, _, error) in
        //            if let error = error {
        //                print("Erro: \(error.localizedDescription)")
        //            }
        //            guard let jsonData = data else {return}
        //            let decoder = JSONDecoder()
        //
        //            do {
        //                let decodeData = try decoder.decode([testJson].self, from: jsonData)
        //                self.personData = decodeData
        //            }
        //            catch{
        //                print("error")
        //            }
        //        }
        //        dataTask.resume()    }
    }
}
