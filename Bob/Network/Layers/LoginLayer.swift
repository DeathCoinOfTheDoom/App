//
//  LoginLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 13/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

typealias CallbackMovies = (_ movies: [User], _ error: Error?) -> Void

class MovieService {
    static func searchMovies(query: String, header: HeaderBuilder.headers, callback: @escaping CallbackMovies) {
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
