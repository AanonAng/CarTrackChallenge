//
//  Address.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation

class Address: NSObject {
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    
    convenience init(dict: NSDictionary?) {
        self.init()
        self.street = dict?["street"] as? String ?? ""
        self.suite = dict?["suite"] as? String ?? ""
        self.city = dict?["city"] as? String ?? ""
        self.zipcode = dict?["zipcode"] as? String ?? ""
    }
}
