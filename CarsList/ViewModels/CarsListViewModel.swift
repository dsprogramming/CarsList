//
//  CarsListViewModel.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation

class CarsListViewModel {
    
    weak var carsDataManager: CarsDataManager!
    private var carsArray: [Car]!
    private var cellsArray: [CarHeaderViewModel]!
    
    init(carsDataManager: CarsDataManager) {
        self.carsDataManager = carsDataManager
        cellsArray = [CarHeaderViewModel]()
    }
    
    func getCarsList(type: CarsListType, completion: () -> Void) {
        
        cellsArray.removeAll()
        self.carsDataManager.getCarsList(type: type) { (cars) in
            self.carsArray = cars
        }
        for car in carsArray {
            let carViewModel = CarHeaderViewModel(car: car)
            cellsArray.append(carViewModel)
        }
        completion()
    }
    
    var numberOfCars: Int {
        return cellsArray.count
    }
    
    var isEmpty: Bool {
        return cellsArray.count == 0 ? true : false
    }
    
    func cellViewModel(index: Int) -> CarHeaderViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
}
