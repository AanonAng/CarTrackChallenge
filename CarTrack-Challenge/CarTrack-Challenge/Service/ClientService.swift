//
//  ClientService.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation
import Alamofire

class ClientService {
    // MARK: - Singleton
    static let shared = ClientService()

    // MARK: - Services
    func userRequest(completion: @escaping(Result<[User], Error>) -> Void) {
        BaseService.shared.getRequest(urlType: Constants.UrlType.users) { result in
            switch result {
            case .success(let response):
                var users: [User] = []
                if let array = response as? [NSDictionary] {
                    for dict in array {
                        let user = User(dict: dict)
                        users.append(user)
                    }
                    completion(.success(users))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
