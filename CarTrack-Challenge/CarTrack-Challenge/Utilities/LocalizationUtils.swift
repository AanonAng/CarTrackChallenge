//
//  LocalizationUtils.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation

let presetDefaultLanguage = "en"

/**
 Friendly localization syntax, replaces NSLocalizedString
 - Returns: The localized string.
*/
public func localizedString(_ key: String) -> String {
    if let path = Bundle.main.path(forResource: Localization.currentLanguage(), ofType: "lproj"), let bundle = Bundle(path: path) {
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
        
    } else {
        let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

public func localizedString(format: String, _ arguments: CVarArg...) -> String {
    return String(format: NSLocalizedString(format, comment: ""), arguments: arguments)
}

open class Localization: NSObject {

    /**
     List available languages
     - Returns: Array of available languages.
    */
    open class func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        var availableLanguages = Bundle.main.localizations

        if let indexOfBase = availableLanguages.firstIndex(of: "Base"), excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        
        return availableLanguages
    }
    
    /**
     Current language
     - Returns: The current language. String.
    */
    open class func currentLanguage() -> String {
        var currentLanguage = readString(forKey: Constants.UserDefaultKey.currentLanguage)
        
        if currentLanguage == "" {
            currentLanguage = defaultLanguage()
        }
        return currentLanguage
    }
    
    /**
     Change the current language
     - Parameter language: Desired language.
    */
    open class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        
        if selectedLanguage != currentLanguage() {
            save(forKey: Constants.UserDefaultKey.currentLanguage, value: selectedLanguage)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .languageDidChanged, object: nil)
        }
    }

    /**
     Default language
     - Returns: The app's default language. String.
    */
    open class func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return presetDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = presetDefaultLanguage
        }
        return defaultLanguage
    }
    
    /**
     Resets the current language to the default
    */
    open class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /**
     Get the current language's display name for a language.
     - Parameter language: Desired language.
     - Returns: The localized string.
    */
    open class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}
