//
//  CarOwner.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import Foundation

struct CarOwner {
    
    let id: Int
    let name: String
    let phone: String
    
    init(id: Int, name: String, phone: String) {
        self.id = id
        self.name = name
        self.phone = phone
    }
}
