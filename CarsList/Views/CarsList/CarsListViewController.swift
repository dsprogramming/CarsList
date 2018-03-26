//
//  CarsListViewController.swift
//  CarsList
//
//  Created by ss on 25/03/18.
//  Copyright © 2018 Abakumov. All rights reserved.
//

import UIKit

class CarsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var viewModel: CarsListViewModel!
    @IBOutlet weak var selectListLabel: UILabel!
    
    let carHeaderIdentifier = String(describing: CarHeaderView.self)
    let carOwnerCellIdentifier = String(describing: CarOwnerCell.self)
    let tableHeaderHeight: CGFloat = 100
    let tableRowHeight: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: carHeaderIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: carHeaderIdentifier)
        tableView.register(UINib(nibName: carOwnerCellIdentifier, bundle: nil), forCellReuseIdentifier: carOwnerCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = tableRowHeight
        self.tableView.estimatedSectionHeaderHeight = tableHeaderHeight;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.automaticallyAdjustsScrollViewInsets = false;
        tableView.isHidden = viewModel.isEmpty
    }
    
    private func setupNavigationBar() {
        self.title = "Cars List"
        let leftButton = UIBarButtonItem(title: "short", style: UIBarButtonItemStyle.plain, target: self, action: #selector(shortBarButtonTapped(_ :)))
        let rightButton = UIBarButtonItem(title: "long", style: UIBarButtonItemStyle.plain, target: self, action: #selector(longBarButtonTapped(_ :)))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func shortBarButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.getCarsList(type: .short) {
            updateTable()
        }
    }
    
    @objc func longBarButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.getCarsList(type: .long) {
            updateTable()
        }
    }
    
    private func updateTable() {
        tableView.reloadData()
        if !viewModel.isEmpty  {
            tableView.alpha = 0.0
            tableView.isHidden = false
            selectListLabel.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.alpha = 1.0
            })
        }
    }
    
    func callPhone(number: String) {
        let alert = UIAlertController(title: "Number", message: number, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default) { (action) in
            guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url)  else { return }
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

}

// MARK: - Table View

extension CarsListViewController: UITableViewDataSource, UITableViewDelegate, CarHeaderDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfCars
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carCellViewModel = viewModel.cellViewModel(index: section) else { return 0 }
        return carCellViewModel.isExpanded ? carCellViewModel.ownersCount : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: carHeaderIdentifier) as! CarHeaderView
        header.delegate = self
        header.section = section
        header.viewModel = viewModel.cellViewModel(index: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: carOwnerCellIdentifier, for: indexPath) as! CarOwnerCell
        let carCellViewModel = viewModel.cellViewModel(index: indexPath.section)
        let carOwnerCellViewMoodel = carCellViewModel?.ownerViewModel(index: indexPath.row)
        cell.viewModel = carOwnerCellViewMoodel
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeaderHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard   let carCellViewModel = viewModel.cellViewModel(index: indexPath.section),
                let carOwnerCellViewMoodel = carCellViewModel.ownerViewModel(index: indexPath.row) else { return }
        if carOwnerCellViewMoodel.phoneAvailable {
            callPhone(number: carOwnerCellViewMoodel.phone)
        }
    }
    
    func didSelectCar(header: CarHeaderView, section: Int) {
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: section) , with: .automatic)
        tableView.endUpdates()
    }
    
}

// MARK: - View Controller Instance

extension CarsListViewController {
    
    static func storyboardInstance() -> CarsListViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? CarsListViewController else {
            fatalError("Cannot instantiate view controller of type \(String(describing: self))")
        }
        return viewController
    }
}
