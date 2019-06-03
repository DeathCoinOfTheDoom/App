import UIKit

struct FolderCreation: Codable {
    var data: FolderCreationData
}
struct FolderCreationData: Codable {
    let type: String
    let id: String
    let attributes: FolderCreationAttr
}
struct FolderCreationAttr: Codable {
    let title: String
}
