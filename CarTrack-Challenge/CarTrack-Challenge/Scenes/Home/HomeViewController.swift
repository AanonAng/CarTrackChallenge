//
//  HomeViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit
import RxDataSources

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setText()
        self.tableView.rowHeight = 150
        
        let viewModel = HomeViewModel(clientService: ClientService())
        
        self.showActivityIndicator()
        viewModel.fetchUsersObserver
            .bind(to: tableView.rx.items(cellIdentifier: "HomeCell", cellType: HomeCell.self)) { (row, element, cell) in
                self.hideActivityIndicator()
                cell.updateDisplay(user: element)
            }
            .disposed(by: disposebag)
        
        
        viewModel.fetchUserErrorObserver
            .subscribe(onNext: { [weak self] error in
                if error.count > 0 {
                    self?.hideActivityIndicator()
                    self?.showAlert(title: "", message: error)
                }
            })
            .disposed(by: disposebag)
        
//        viewModel.countries.drive(tableView.rx.items(cellIdentifier: "CountryCell", cellType: CountryCell.self)) { (row, element, cell) in
//            cell.updateDisplay(country: element, selectedCountry: self.currentCountry)
//        }.disposed(by: disposebag)
    }
    
    func setText() {
        self.navigationItem.title = localizedString("__t_home_title")
    }
}
