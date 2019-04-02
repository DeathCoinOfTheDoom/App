//
//  FolderLayer.swift
//  Bob
//
//  Created by Isabelle Melchiori on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


typealias CallbackUserFolders = (_ userFolder: [UserFolderData], _ error: Error?) -> Void

class UserService {
    static func folders(query: String, header: HTTPHeaders, callback: @escaping CallbackUserFolders) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    print("data", data)
                    let result = try jsonDecoder.decode(UserFolder.self, from: data)
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
