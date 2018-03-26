//
//  UIColor.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import UIKit

extension UIColor {

    static func from(string: String) -> UIColor {
        
        var color: UIColor
        
        switch string {
        case "red":
            color = .red
        case "green":
            color = .green
        case "blue":
            color = .blue
        case "yellow":
            color = .yellow
        case "white":
            color = .white
        case "black":
            color = .black
        case "gray":
            color = .gray // and so on...
        default:
            color = .clear
        }
        
        return color
    }
    
}
