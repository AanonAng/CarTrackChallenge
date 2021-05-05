//
//  BaseViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String? = nil, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedString("__t_global_ok"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
