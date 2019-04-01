//
//  LoginLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

typealias CallbackUser = (_ movies: [User], _ error: Error?) -> Void

class LoginService {
    static func login(query: String, header: HTTPHeaders, callback: @escaping CallbackUser) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url).responseData { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    // on parse les data pour obtenir un objet de type ResultMovie
                    let result = try jsonDecoder.decode(User.self, from: data)
                    print("result", result)
                } catch let error {
                    // Erreur de parsing
                    callback([], error)
                }
            case .failure(let error) :
                // Erreur de la requête
                callback([], error)
            }
        }
    }
}
