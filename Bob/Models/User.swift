//
//  User.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    let attributes: UserAttr
}

struct UserAttr : Codable {
    var phoneNumber: String
    var email: String
    var firstName: String
    var lastName: String
    var admin: String
    var createdAt: String
    var updatedAt: String
}

struct UserFolder: Codable {
    var data: [UserFolderData]
}

struct UserFolderData: Codable {
    var type: String
    var id: String
    var attributes: UserFolderAttr
    //TODO FILES ARRAY
}

struct UserFolderAttr: Codable {
    var title: String
    var createdAt: String
    var updatedAt: String
}

