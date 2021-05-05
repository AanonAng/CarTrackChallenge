//
//  HomeViewModel.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    
    private var clientService: ClientService?
    
    private var users = BehaviorRelay(value: [User]())
    var fetchUsersObserver: Observable<[User]> {
        return users.asObservable()
    }
    
    private var fetchUserError = BehaviorRelay(value: "")
    var fetchUserErrorObserver: Observable<String> {
        return fetchUserError.asObservable()
    }
    
    init(clientService: ClientService) {
        self.clientService = clientService
        self.fetchUsers()
    }
    
    private func fetchUsers() {
        self.clientService?.userRequest(completion: { result in
            switch result {
            case .success(let fetchedUsers):
                self.users.accept(fetchedUsers)
            case .failure(let error):
                self.fetchUserError.accept(error.localizedDescription)
            }
        })
    }
}
