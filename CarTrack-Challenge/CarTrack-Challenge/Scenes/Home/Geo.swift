//
//  Geo.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import Foundation

class Geo: NSObject {
    var lat: String = ""
    var long: String = ""
    
    convenience init(dict: NSDictionary?) {
        self.init()
        self.lat = dict?["lat"] as? String ?? ""
        self.long = dict?["lng"] as? String ?? ""
    }
}
