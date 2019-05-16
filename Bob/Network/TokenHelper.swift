//
//  TokenHelper.swift
//  Bob
//
//  Created by Gérome Lacaux on 01/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

class TokenHelper {
    let defaults = UserDefaults.standard
    func setToken(token: String) {
        defaults.set(token, forKey: "token")
    }
    func getToken(key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
}
