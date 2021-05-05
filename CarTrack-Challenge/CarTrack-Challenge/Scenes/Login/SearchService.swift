//
//  SearchService.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchService {
    static let shared = SearchService()
    private init() {}
    
    /// get countries with or without search text
    func getCountries(withSearchText text: String) -> Observable<[String]> {
        let countries = getCountries()
        
        if text == "" {
            return Observable.just(countries).observe(on: MainScheduler.instance)
        }
        
        var searchedCountries: [String] = []
        for country in countries {
            if country.contains(text) {
                searchedCountries.append(country)
            }
        }
        return Observable.just(searchedCountries).observe(on: MainScheduler.instance)
    }
    
    
    /// Get countries with sorted
    private func getCountries() -> [String] {
        var unsortCountries: [String] = []
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            unsortCountries.append(name)
        }
        return unsortCountries.sorted { $0 < $1 }
    }
}
