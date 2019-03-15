//
//  FolderLayer.swift
//  Bob
//
//  Created by Gérome Lacaux on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

typealias CallbackAllCategory = (_ categories: [Category], _ error: Error?) -> Void

class CategoryService {
    static func all(query: String, header: HTTPHeaders, callback: @escaping CallbackAllCategory) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(DataCategory.self, from: data)
                    callback(result.data, nil)
                } catch let error {
                    print("Erreur de parsing", error)
                    // Erreur de parsing
                    callback([], error)
                }
            case .failure(let error) :
                print("Erreur de la requête")
                // Erreur de la requête
                callback([], error)
            }
        }
    }
}