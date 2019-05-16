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
    func setUserId(id: String) {
        defaults.set(id, forKey: "id")
    }
    func getUserInfos(key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
}
