//
//  Login.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import Foundation

class Login: ObservableObject {
    var username: String = ""
    var password: String = ""
    var country: String = ""
    
    convenience init(username: String, password: String, country: String) {
        self.init()
        self.username = username
        self.password = password
        self.country = country
    }
}
