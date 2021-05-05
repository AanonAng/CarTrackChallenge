//
//  ValidationService.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation
import RxSwift
import RxCocoa

class DefaultValidationService: ValidationService {

    static let shared = DefaultValidationService()
    private init() {}
    let minPasswordCount = 5
    
    func validateUsername(_ name: String) -> Observable<ValidationResult> {
        let numberOfCharacters = name.count
        if numberOfCharacters == 0 {
            return Observable.just(ValidationResult.empty(message: localizedString("__t_login_username_empty")))
        }
        return Observable.just(ValidationResult.ok)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty(message: localizedString("__t_login_password_empty"))
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: String(format: localizedString("__t_login_password_length"), minPasswordCount))
        }
        
        return .ok
    }
    
    func validateCountry(_ country: String) -> ValidationResult {
        let placeholder = localizedString("__t_login_country")
        if placeholder.lowercased() == country.lowercased() {
            return .empty(message: localizedString("__t_login_country_empty"))
        }
        
        return .ok
    }
}

class DefaultDataBase: DataBase {
    static let shared = DefaultDataBase()
    private init() {}
    
    func login(_ username: String, password: String, country: String) -> Observable<Bool> {
        return Observable.just(true)
    }
}
