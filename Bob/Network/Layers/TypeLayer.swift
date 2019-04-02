//
//  TypeLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire

typealias CallbackGetType =  (_ type: TypeData?, _ error: Error?) -> Void

class TypeService {
    static func getType(query: String, header: HTTPHeaders, callback: @escaping CallbackGetType) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(Type.self, from: data)
                    callback(result.data, nil)
                } catch let error {
                    print("Erreur de parsing", error)
                    // Erreur de parsing
                    callback(nil, error)
                }
            case .failure(let error) :
                print("Erreur de la requête")
                // Erreur de la requête
                callback(nil, error)
            }
        }
    }
}
