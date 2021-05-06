//
//  LoginViewModel.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let disposebag = DisposeBag()
    
    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedCountry: Observable<ValidationResult>
    
    let loginEnabled: Observable<Bool>
    let logined: Observable<Bool>
    
    init(input: (
            username: Observable<String>,
            password: Observable<String>,
            country: Observable<String>,
            countryDidTap: Observable<Void>,
            loginDidTap: Observable<Void>
        ),
        dependency: (
            dataBase: DataBase,
            validationService: ValidationService
        )
    ) {
        
        let database = dependency.dataBase
        let validationService = dependency.validationService
        
            
        validatedUsername = input.username
            .flatMapLatest { username in
                return validationService.validateUsername(username)
                    .observe(on:MainScheduler.instance)
                    .catchAndReturn(.failed(message: "Username not valid"))
            }
            .share(replay: 1)
        
        validatedPassword = input.password
            .map({ password in
                return validationService.validatePassword(password)
            })
            .share(replay: 1)
        
        validatedCountry = input.country
            .map({ country in
                return validationService.validateCountry(country)
            })
            .share(replay: 1)

        let loginInfo = Observable.combineLatest(input.username, input.password, input.country) {(username: $0, password: $1, country: $2)}
        
        logined = input.loginDidTap.asObservable().withLatestFrom(loginInfo)
            .flatMapLatest{ pair in
                return database.login(pair.username, password: pair.password)
                .observe(on: MainScheduler.instance)
                .catchAndReturn(false)
            }.share(replay: 1)
        
        loginEnabled = Observable.combineLatest(validatedUsername, validatedPassword, validatedCountry) { username, password, country in
            username.isValid && password.isValid && country.isValid
        }
        .distinctUntilChanged()
        .share(replay: 1)
    }
}
