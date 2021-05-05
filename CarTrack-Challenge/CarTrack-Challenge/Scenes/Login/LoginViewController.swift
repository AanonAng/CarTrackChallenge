//
//  LoginViewController.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var countryValidationLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setText()
        self.setupLoginView()
        self.setupCountryButton()
        self.setupLoginButton()
        
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
        
        viewModel.loginEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposebag)
        
        viewModel.logined.subscribe(onNext: { logined in
            print("user login: \(logined)")
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

}
