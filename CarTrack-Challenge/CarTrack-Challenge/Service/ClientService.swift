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
    
    // MARK: - URL
    private var baseUrl = "https://jsonplaceholder.typicode.com/"
    
    // MARK: - Services
    func userRequest(completion: @escaping(Result<[User], Error>) -> Void) {
        let url = "\(baseUrl)\(Constants.UrlType.users)"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let dicts = value as? [NSDictionary] {
                    var users: [User] = []
                    for dict in dicts {
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
