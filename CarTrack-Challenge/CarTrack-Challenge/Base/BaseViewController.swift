//
//  BaseViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    let disposebag = DisposeBag()
    
    lazy var activityIndicatorView: NVActivityIndicatorView = {
        let frame = CGRect(x: self.view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: UIColor.systemBlue, padding: 0)
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.activityIndicatorView)
    }
    
    func showAlert(title: String? = nil, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedString("__t_global_ok"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        self.activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicatorView.stopAnimating()
    }
}
