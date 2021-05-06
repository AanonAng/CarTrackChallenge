//
//  Login.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import Foundation
import CoreData
import RxCoreData

struct Login {
    var id: String = ""
    var username: String = ""
    var password: String = ""
    var country: String = ""
}

extension Login : Equatable { }

extension Login: Persistable {
    var identity: String {
        return id
    }
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "Login"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id = entity.value(forKey: "id") as! String
        username = entity.value(forKey: "username") as! String
        password = entity.value(forKey: "password") as! String
        country = entity.value(forKey: "country") as! String
    }
    
    func update(_ entity: T) {
        entity.setValue(id, forKey: "id")
        entity.setValue(username, forKey: "username")
        entity.setValue(password, forKey: "password")
        entity.setValue(country, forKey: "country")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
