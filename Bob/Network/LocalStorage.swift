//
//  TokenHelper.swift
//  Bob
//
//  Created by Gérome Lacaux on 01/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

class LocalStorage {
    let defaults = UserDefaults.standard
    func setUserInfos(key: String, value: String) {
        defaults.set(value, forKey: key)
    }
    func getUserInfos(key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
}
