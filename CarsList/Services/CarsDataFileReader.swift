//
//  CarsDataFileReader.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation

class CarsDataFileReader: CarsDataManager {

    func getCarsList(type: CarsListType, completion: @escaping ([Car]) -> Void) {
    
        // perform some requests to server or DB
        let cars = readJson(file: type.rawValue)
        
        //perform in main thread
        completion(cars)
        
    }
    
    private func readJson(file: String) -> [Car] { // for pure Swift 4 style we could use Codable Protocol
        var cars = [Car]()
        do {
            if let file = Bundle.main.url(forResource: file, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let carsArray = json as? [[String: Any]] else { fatalError("Incorrect json format") }
                
                for carDict in carsArray {
                    guard   let id = carDict["car_id"] as? Int,
                        let model = carDict["car_model"] as? String,
                        let type = carDict["car_type"] as? String,
                        let color = carDict["car_color"] as? String,
                        let carOwnersArray = carDict["owners"] as? [[String: Any]] else { fatalError("Incorrect json format") }
                    
                    var carOwners = [CarOwner]()
                    for carOwnerDict in carOwnersArray {
                        guard   let id = carOwnerDict["owner_id"] as? Int,
                            let name = carOwnerDict["owner_name"] as? String,
                            let phone = carOwnerDict["owner_phone"] as? String else { fatalError("Incorrect json format") }
                        let carOwner = CarOwner(id: id, name: name, phone: phone)
                        carOwners.append(carOwner)
                    }
                    
                    let car = Car(id: id, type: type, model: model, color: color, owners: carOwners)
                    cars.append(car)
                }
            } else {
                fatalError("File not found")
            }
        } catch {
            print(error.localizedDescription)
        }
        return cars
    }
    
}
