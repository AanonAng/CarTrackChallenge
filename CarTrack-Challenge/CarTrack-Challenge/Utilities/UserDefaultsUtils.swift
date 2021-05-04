//
//  UserDefaultsUtils.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 4/5/21.
//

import Foundation

let userDefaults = UserDefaults.standard

func save(forKey key: String, value: String) {
    userDefaults.set(value, forKey: key)
}

func save(forKey key: String, value: Int) {
    userDefaults.set(value, forKey: key)
}

func save(forKey key: String, value: Double) {
    userDefaults.set(value, forKey: key)
}

func save(forKey key: String, value: Bool) {
    userDefaults.set(value, forKey: key)
}

func save(forKey key: String, value: Data) {
    userDefaults.set(value, forKey: key)
}

func readString(forKey key: String) -> String {
    return userDefaults.string(forKey: key) ?? ""
}

func readInt(forKey key: String) -> Int {
    return userDefaults.integer(forKey: key)
}

func readDouble(forKey key: String) -> Double {
    return userDefaults.double(forKey: key)
}

func readBool(forKey key: String) -> Bool {
    return userDefaults.bool(forKey: key)
}

func readData(forKey key: String) -> Data? {
    if let data = userDefaults.data(forKey: key) {
        return data
    }
    return nil
}

func remove(forKey key: String) {
    userDefaults.removeObject(forKey: key)
}

func removeAll() {
    if let appDomain = Bundle.main.bundleIdentifier {
        userDefaults.removePersistentDomain(forName: appDomain)
    }
}
