//
//  ValidationService.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

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
        if placeholder.lowercased() == country.lowercased() || country.count == 0 {
            return .empty(message: localizedString("__t_login_country_empty"))
        }
        
        return .ok
    }
}

class DefaultDataBase: DataBase {
    static let shared = DefaultDataBase()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private init() {}
    
    func login(_ username: String, password: String) -> Observable<Bool> {
        var isValidLogin: Bool = false
        
        let managedObjectContext = self.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Login")

        do {
            let fetchedEmployees = try managedObjectContext.fetch(fetchRequest)
            if fetchedEmployees.count > 0 {
                let savedUsername = fetchedEmployees[0].value(forKey: "username") as? String
                let savedPassword = fetchedEmployees[0].value(forKey: "password") as? String
                if savedUsername == username && savedPassword == password {
                    isValidLogin = true
                }
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        return Observable.just(isValidLogin)
    }
}
