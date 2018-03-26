//
//  CarOwnerCell.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import UIKit

class CarOwnerCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    weak var viewModel: CarOwnerCellViewModel! {
        didSet {
            nameLabel.text = viewModel.name
            phoneLabel.text = viewModel.phone
        }
    }
    
}
