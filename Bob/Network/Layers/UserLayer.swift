//
//  FolderLayer.swift
//  Bob
//
//  Created by Isabelle Melchiori on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire


typealias CallbackUserFolders = (_ userFolder: [UserFolderData], _ error: Error?) -> Void

typealias CallbackUserInfos = (_ userInfos: UserInfosData? , _ error: Error?) -> Void


class UserService {
    static func userInfos(query: String, header: HTTPHeaders, callback: @escaping CallbackUserInfos) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserInfos.self, from: data)
                    callback(result.data, nil)
                } catch let error {
                    print("erreur de parsing")
                    callback(nil, error)
                }
            case .failure(let error) :
                callback(nil, error)
            }
        }
    }
    
    
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
                    callback([], error)
                }
            case .failure(let error) :
                print("Erreur de la requête")
                callback([], error)
            }
        }
    }
}
