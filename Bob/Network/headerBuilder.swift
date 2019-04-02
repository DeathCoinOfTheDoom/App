//
//  headerBuilder.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

class HeaderBuilderBob {
    static var headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    static func setToken(token: String){
        headers["Authorization"] = "Bearer token:\(token)"
    }
}
