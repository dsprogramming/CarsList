//
//  CarHeaderView.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import UIKit

protocol CarHeaderDelegate: class {
    func didSelectCar(header: CarHeaderView, section: Int)
}

class CarHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var colorView: UIView!

    weak var delegate: CarHeaderDelegate?
    var section: Int = 0

    let pixelSize = 1.0 / UIScreen.main.scale
    private let separator = UIView()
    
    weak var viewModel: CarHeaderViewModel! {
        didSet {
            self.modelLabel.text = viewModel.model
            self.typeLabel.text = viewModel.type
            self.ownerLabel.text = viewModel.ownersLabel
            self.colorView.backgroundColor = viewModel.color
            self.separator.isHidden = viewModel.isExpanded
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        let tapRecognize = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognizer:)))
        self.addGestureRecognizer(tapRecognize)
    }
    
    func setupViews() {
        colorView.layer.borderWidth = pixelSize
        colorView.layer.borderColor = UIColor.darkGray.cgColor
        colorView.layer.cornerRadius = colorView.bounds.width / 2.0
        separator.backgroundColor = .darkGray
        self.addSubview(separator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let separatorFrame = CGRect(x: 0, y: self.bounds.maxY - pixelSize, width: self.bounds.maxX, height: pixelSize)
        separator.frame = separatorFrame
        if let viewModel = viewModel {
            separator.isHidden = viewModel.isExpanded && viewModel.haveOwners
        }
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        viewModel.isExpanded = !viewModel.isExpanded
        guard let delegate = delegate else { return }
        delegate.didSelectCar(header: self, section: section)
    }

}
