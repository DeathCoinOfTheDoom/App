//
//  LoginLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

typealias CallbackLoginValidation = (_ code: Int, _ error: Error?) -> Void

class LoginService {
    static func validation(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackLoginValidation) {
        let url = UrlBuilder.searchUrl(query: query)
        print("payload", payload)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            callback(response.value as! Int, nil)
        }
    }
}
