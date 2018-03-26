//
//  CarHeaderViewModel.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import UIKit // we should not use UIKit in View Model, but for an example of color formatting

class CarHeaderViewModel {
    
    let type: String
    let model: String
    let color: UIColor
    let ownersLabel: String
    private var ownersArray: [CarOwnerCellViewModel]
    var isExpanded = false
    
    init(car: Car) {
        self.type = car.type.isEmpty ? "unknown" : car.type
        self.model = car.model.isEmpty ? "Unknown" : car.model.capitalized
        self.color = UIColor.from(string: car.color)
        
        switch car.owners.count {
        case 0:
            self.ownersLabel = "no owners"
        case 1:
            self.ownersLabel = "single owner"
        default:
            self.ownersLabel = "few owners"
        }
        
        ownersArray = []
        for owner in car.owners {
            let carOwnerCellViewModel = CarOwnerCellViewModel(carOwner: owner)
            ownersArray.append(carOwnerCellViewModel)
        }
    }
    
    var ownersCount: Int {
        return ownersArray.count
    }
    
    var haveOwners: Bool {
        return ownersArray.count > 0 ? true : false
    }
    
    func ownerViewModel(index: Int) -> CarOwnerCellViewModel? {
        guard index < ownersArray.count else { return nil }
        return ownersArray[index]
    }
    
}
