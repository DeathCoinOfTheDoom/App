//
//  Category.swift
//  Bob
//
//  Created by Gérome Lacaux on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

struct Category: Codable {
    var type: String
    var id: String
    let attributes: CategoryAttr
}

struct CategoryAttr: Codable {
    var title: String
}
