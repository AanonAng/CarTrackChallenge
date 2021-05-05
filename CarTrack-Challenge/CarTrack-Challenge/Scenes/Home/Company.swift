//
//  Company.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation

class Company: NSObject {
    var name: String = ""
    var catchPhrase: String = ""
    var bs: String = ""
    
    convenience init(dict: NSDictionary?) {
        self.init()
        self.name = dict?["name"] as? String ?? ""
        self.catchPhrase = dict?["catchPhrase"] as? String ?? ""
        self.bs = dict?["bs"] as? String ?? ""
    }
}
