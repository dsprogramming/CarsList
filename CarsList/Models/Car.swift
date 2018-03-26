//
//  Car.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation

struct Car {

    let id: Int
    let type: String
    let model: String
    let color: String
    let owners: [CarOwner]
    
    init(id: Int, type: String, model: String, color: String, owners: [CarOwner]) {
        self.id = id
        self.type = type
        self.model = model
        self.color = color
        self.owners = owners
    }
 }
