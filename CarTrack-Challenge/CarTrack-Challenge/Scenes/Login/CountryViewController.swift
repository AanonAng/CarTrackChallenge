//
//  CountryViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import UIKit
import RxSwift
import RxCocoa

class CountryViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var currentCountry = ""
    private var selectedCountry = BehaviorRelay(value: "")
    var selectedObserver: Observable<String> {
        return selectedCountry.asObservable()
    }
    
    var searchBarText: Observable<String> {
        return searchBar.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(Int(0.3)), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.tableView.rowHeight = 44.0
        self.setText()
        
        self.selectedCountry.accept(self.currentCountry)
        let viewModel = CountryViewModel(with: searchBarText, service: SearchService.shared)
        
        viewModel.countries.drive(tableView.rx.items(cellIdentifier: "CountryCell", cellType: CountryCell.self)) { (row, element, cell) in
            cell.updateDisplay(country: element, selectedCountry: self.currentCountry)
        }.disposed(by: disposebag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] value in
                self?.selectedCountry.accept(value)
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposebag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setText() {
        self.navigationItem.title = localizedString("__t_country_username")
    }
}
