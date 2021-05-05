//
//  User.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation

class User: NSObject {
    var id: Int = 0
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var phone: String = ""
    var website: String = ""
    var address: Address?
    var geo: Geo?
    var company: Company?
    
    convenience init(dict: NSDictionary?) {
        self.init()
        self.id = dict?["id"] as? Int ?? 0
        self.name = dict?["name"] as? String ?? ""
        self.username = dict?["username"] as? String ?? ""
        self.email = dict?["email"] as? String ?? ""
        self.phone = dict?["phone"] as? String ?? ""
        self.website = dict?["website"] as? String ?? ""
        self.address = Address(dict: dict?["address"] as? NSDictionary)
        self.geo = Geo(dict: dict?["geo"] as? NSDictionary)
        self.company = Company(dict: dict?["company"] as? NSDictionary)
    }
}
