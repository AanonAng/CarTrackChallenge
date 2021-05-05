//
//  LoginViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit
import RxCocoa
import RxSwift
import CoreData
import RxCoreData

class LoginViewController: BaseViewController {

    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var countryValidationLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var selectedCountry = BehaviorRelay(value: "")
    
    var countryObserver: Observable<String> {
        return selectedCountry.asObservable()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.setText()
        self.setupLoginView()
        self.setupCountryButton()
        self.setupLoginButton()
        
        self.createMockLoginInfo()
        
        // End editing when tap background view
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposebag)
        view.addGestureRecognizer(tapGesture)
        
        let viewModel = LoginViewModel(
            input: (
                username: self.usernameTextField.rx.text.orEmpty.asObservable(),
                password: self.passwordTextField.rx.text.orEmpty.asObservable(),
                country: countryObserver,
                countryDidTap: self.countryButton.rx.tap.asObservable(),
                loginDidTap: loginButton.rx.tap.asObservable()),
            dependency: (
                dataBase: DefaultDataBase.shared,
                validationService: DefaultValidationService.shared
            )
        )
        
        viewModel.validatedUsername
            .bind(to: usernameValidationLabel.rx.validationResult)
            .disposed(by: disposebag)
        
        viewModel.validatedPassword
            .bind(to: passwordValidationLabel.rx.validationResult)
            .disposed(by: disposebag)
        
        viewModel.validatedCountry
            .bind(to: countryValidationLabel.rx.validationResult)
            .disposed(by: disposebag)
        
        viewModel.loginEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposebag)
        
        viewModel.logined.subscribe(onNext: { success in
            if success {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                let nc = UINavigationController(rootViewController: vc)
                
                self.view.window?.rootViewController = nc
                self.view.window?.makeKeyAndVisible()
            } else {
                self.showAlert(title: "", message: localizedString("__t_login_failed"))
            }
        })
        .disposed(by: disposebag)
        
        self.countryButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
                let vc = self?.storyboard?.instantiateViewController(identifier: "CountryViewController") as! CountryViewController
                // Update button title when user selected country
                vc.selectedObserver
                    .subscribe(onNext: { [weak self] selectedCountry in
                        if selectedCountry.count > 0 {
                            self?.countryButton.setTitle(selectedCountry, for: .normal)
                            self?.countryButton.setTitleColor(.black, for: .normal)
                            self?.selectedCountry.accept(selectedCountry)
                        }
                    })
                    .disposed(by: self!.disposebag)
                
                // Pass current selected country to countryVC
                if self?.countryButton.titleLabel?.text != localizedString("__t_login_country") {
                    vc.currentCountry = self?.countryButton.titleLabel?.text ?? ""
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposebag)
    }
    
    func setText() {
        self.usernameTextField.placeholder = localizedString("__t_login_username")
        self.passwordTextField.placeholder = localizedString("__t_login_password")
        self.countryButton.setTitle(localizedString("__t_login_country"), for: .normal)
        self.loginButton.setTitle(localizedString("__t_login_login"), for: .normal)
    }
    
    func setupLoginView() {
        self.loginView.layer.cornerRadius = 8.0
    }
    
    func setupCountryButton() {
        self.countryButton.layer.cornerRadius = 5.0
        self.countryButton.layer.borderWidth = 0.25
        self.countryButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupLoginButton() {
        self.loginButton.layer.cornerRadius = 8.0
    }

    // MARK: Mock Login Info
    func createMockLoginInfo() {
        let managedObjectContext = self.appDelegate.managedObjectContext
        
        managedObjectContext.rx.entities(Login.self)
            .subscribe({ logins in
                if logins.element?.count == 0 {
                    let login = Login(id: "1", username: "aaron", password: "abcd1234", country: "Singapore")
                    try? managedObjectContext.rx.update(login)
                }
            })
            .disposed(by: disposebag)
    }
}
