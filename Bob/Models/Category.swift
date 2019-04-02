//
//  Category.swift
//  Bob
//
//  Created by Gérome Lacaux on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

// All endpoint
struct Category: Codable {
    var data: [CategoryData]
}

struct CategoryData: Codable {
    var type: String
    var id: String
    var attributes: CategoryAttr
}

struct CategoryAttr: Codable {
    var title: String
    var icon: String
    var description: String
    var extendedDescription : String
}
