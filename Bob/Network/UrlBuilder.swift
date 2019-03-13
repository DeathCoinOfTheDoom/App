//
//  UrlBuilder.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

class UrlBuilder {
    static let baseUrl = "http://104.248.229.222"
    
    static func searchUrl(query: String) -> String {
        return "\(baseUrl)/\(query)"
    }
}

