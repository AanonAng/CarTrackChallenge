//
//  AlertUtils.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import UIKit

class Alert: NSObject {

    /// customize cancel message and confirm message
    /// Show alert with cancel button
    /// Include confirm action
    static func show(_ vc: UIViewController, title: String? = nil, message: String? = nil, confirmMessage: String = localizedString("__t_global_ok"), confirmCallback: (() -> Void)?, cancelMessage: String = localizedString("__t_global_cancel"), cancelCallback: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmMessage, style: .default, handler: { (action) in
            confirmCallback?()
        }))
        alert.addAction(UIAlertAction(title: cancelMessage, style: .cancel, handler: { (action) in
            cancelCallback?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// Show alert with cancel button
    /// Include confirm action
    static func show(withCancel vc: UIViewController, title: String? = nil, message: String? = nil, confirmCallback: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedString("__t_global_ok"), style: .default, handler: { (action) in
            confirmCallback?()
        }))
        alert.addAction(UIAlertAction(title: localizedString("__t_global_cancel"), style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// Show alert without cancel button
    /// Include confirm action
    static func show(_ vc: UIViewController, title: String? = nil, message: String? = nil, confirmCallback: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedString("__t_global_ok"), style: .default, handler: { (action) in
            confirmCallback?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// Show alert without cancel button and confirm action
    static func show(_ vc: UIViewController, title: String? = nil, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedString("__t_global_ok"), style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

