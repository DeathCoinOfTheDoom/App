//
//  LoginLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

typealias CallbackLoginValidation = (_ code: Int?, _ error: Error?) -> Void
typealias CallbackAuthCode = (_ user: User?, _ error: Error?) -> Void

class LoginService {
    static func validation(query: String, payload: Parameters, header: HTTPHeaders, phone: String, callback: @escaping CallbackLoginValidation) {
            let url = UrlBuilder.searchUrl(query: query)
            Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                switch response.result {
                    case .success :
                    callback(response.value as? Int, nil)
                    case .failure(let error) :
                    callback(nil, error)
                }
            
            }
    }
    static func authCode(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackAuthCode) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("yoooooo", response.result)
            switch response.result {
            case .success :
                callback(response.value as? User, nil)
            case .failure(let error) :
                callback(nil, error)
            }
            
        }
    }
}
