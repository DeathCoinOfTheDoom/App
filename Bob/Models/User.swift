//
//  User.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import Foundation
import UIKit

 struct UserInfos: Codable {
     var data: UserInfosData
 }

 struct UserInfosData: Codable {
     var type: String
     var id: String
     var attributes: UserInfosAttr
 }
struct UserInfosAttrView: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var birthdate: String
    init(email: String,
        firstName: String,
        lastName: String,
        birthdate: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }
}

struct UserInfosAttr: Codable {
    var phoneNumber: String
    var email: String
    var firstName: String
    var lastName: String
    var birthdate: String
    var admin: String
}
// connection
struct UserAuth: Codable {
    var token: String
    let user: User
}

struct User : Codable {
    var type: String
    var id: String
    var attributes: UserAttr
}

struct UserAttr: Codable {
    var phoneNumber: String
    var email: String?
    var firstName: String?
    var lastName: String?
    var birthdate: Date?
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

// User files
struct UserFiles: Codable {
    var data: [UserFilesData]
}
struct UserFilesData: Codable {
    var type: String
    var id: String
    var attributes: UserFilesAttr
    var relationships: UserFilesRelationships
}
struct UserFilesAttr: Codable {
    var url: String
    var createdAt: String
    var updatedAt: String
}
struct UserFilesRelationships: Codable {
    var type: UserFilesRelationshipsType
}
struct UserFilesRelationshipsType: Codable {
    var data: UserFilesRelationshipsTypeData
}
struct UserFilesRelationshipsTypeData: Codable {
    var type: String
    var id : String
}
// User Post files
struct UserPostFiles {
    var userId: String
    var fileTypeId: String
    var image: UIImage
}
