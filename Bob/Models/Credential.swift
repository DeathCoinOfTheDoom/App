//
//  Credential.swift
//  Bob
//
//  Created by Gérome Lacaux on 26/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

struct Credentials {
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
