import UIKit

class Folder {
    let title:String!
    let description:String!
    //var image:UIImage!
    
    init(title:String, description:String) {
        self.title = title
        self.description = description
    }
}

struct FolderCreation {
    var data: FolderCreationData
}
struct FolderCreationData {
    let type: String
    let id: String
    let attributes: FolderCreationAttr
}
struct FolderCreationAttr {
    let title: String
}
