//
//  CountryViewModel.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import Foundation
import RxSwift
import RxCocoa

class CountryViewModel {
    var countries: Driver<[String]>
    
    init(with searchText: Observable<String>, service: SearchService) {
        countries = searchText
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap{ text in
                return service.getCountries(withSearchText: text)
            }
            .asDriver(onErrorJustReturn: [])
    }
}
