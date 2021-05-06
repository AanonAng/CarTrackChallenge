//
//  BaseService.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation
import Alamofire

class BaseService {
    // MARK: - Singleton
    static let shared = BaseService()
    
    // MARK: - URL
    private var baseUrl = "https://jsonplaceholder.typicode.com/"
    
    // MARK: - Services
    func getRequest(urlType: String, completion: @escaping(Result<Any, Error>) -> Void) {
        
        let url = URL(string: self.baseUrl + urlType)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 15.0
        
        AF.request(request).responseJSON { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
