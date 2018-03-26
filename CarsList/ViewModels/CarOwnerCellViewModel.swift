//
//  CarOwnerCellViewModel.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation

class CarOwnerCellViewModel {
    
    let name: String
    let phone: String
    let phoneAvailable: Bool
    
    init(carOwner: CarOwner) {
        self.name = carOwner.name.isEmpty ? "unknown" : carOwner.name.capitalized
        self.phone = carOwner.phone.isEmpty ? "unknown" : carOwner.phone // for exampel of VM using we could use PhoneNumberKit to format number
        self.phoneAvailable = !carOwner.phone.isEmpty
    }
}
