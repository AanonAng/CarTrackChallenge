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
        
        tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { [weak self] value in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                vc.user = value
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposebag)
    }
    
    func setText() {
        self.navigationItem.title = localizedString("__t_home_title")
    }
}
