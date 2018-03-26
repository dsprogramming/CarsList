//
//  CarsDataManager.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation


enum CarsListType: String {
    case short = "short_list"
    case long = "long_list"
}

protocol CarsDataManager: class {
    func getCarsList(type: CarsListType, completion: @escaping ([Car]) -> Void)
}
