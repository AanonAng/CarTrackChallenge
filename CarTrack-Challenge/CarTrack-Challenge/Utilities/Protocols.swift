//
//  Protocols.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation
import RxSwift
import RxCocoa

enum ValidationResult {
    case ok
    case empty(message: String)
    case validating
    case failed(message: String)
}

protocol DataBase {
    func login(_ username: String, password: String, country: String) -> Observable<Bool>
}

protocol ValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateCountry(_ country: String) -> ValidationResult
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
