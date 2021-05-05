//
//  Binding+Extensions.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation
import RxSwift
import RxCocoa

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .ok:
            return ""
        case let .empty(message):
            return message
        case .validating:
            return ""
        case let .failed(message):
            return message
        }
    }
}

struct ValidationColors {
    static let errorColor = UIColor.red
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor.black
        case .empty:
            return ValidationColors.errorColor
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(self.base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base: UIButton {

    /// Reactive wrapper for `setTitle(_:for:)`
    public func title(for controlState: UIControl.State = []) -> Binder<String?> {
        return Binder(self.base) { button, title -> Void in
            button.setTitle(title, for: controlState)
        }
    }
}
