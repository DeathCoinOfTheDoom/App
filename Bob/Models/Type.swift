//
//  Type.swift
//  Bob
//
//  Created by Gérome Lacaux on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

struct Type: Codable {
    var data: TypeData
}

struct TypeData: Codable {
    var type: String
    var id: String
    var attributes: TypeAttr
}

struct TypeAttr: Codable {
    var title: String
}
