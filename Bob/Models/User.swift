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
    var phoneNumber: String
    init(email: String,
        firstName: String,
        lastName: String,
        birthdate: String, phoneNumber: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.phoneNumber = phoneNumber
    }
}

struct UserInfosAttr: Codable {
    var birthdate: String
    var phoneNumber: String
    var email: String
    var firstName: String
    var lastName: String
}
// connexion
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
    var birthdate: String?
    var createdAt: String
    var updatedAt: String
}
// Folders
struct UserFolders: Codable {
    var data: [UserFolderData]
}
// One Folder
struct UserFolder: Codable {
    var data: UserFolderData
    var meta: UserFolderMeta?
}
struct UserFolderRelationships: Codable {
    var files: UserFolderRelationshipsFiles
}
struct UserFolderRelationshipsFiles: Codable {
    var data: [UserFolderRelationshipsData]
}
struct UserFolderRelationshipsData: Codable {
    var type: String
    var id: String
}

struct UserFolderData: Codable {
    var type: String
    var id: String
    var attributes: UserFolderAttr
    var relationships: UserFolderRelationships
}
struct UserFolderMeta: Codable {
    var zip: String
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
struct UserFile: Codable {
    var data: UserFilesData
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
