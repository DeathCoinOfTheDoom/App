//
//  FolderLayer.swift
//  Bob
//
//  Created by Isabelle Melchiori on 14/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import Alamofire


typealias CallbackUserFiles = (_ userFiles: [UserFilesData], _ error: Error?) -> Void
typealias CallbackUserFile = (_ userFile: UserFilesData?, _ error: Error?) -> Void
typealias CallbackUserEdition = (_ user: UserInfos?, _ error: Error?) -> Void
typealias CallbackUserInfos = (_ userInfos: UserInfosData? , _ error: Error?) -> Void
typealias CallbackUpdateProfile = (_ userInfos: UserInfosData? , _ error: Error?) -> Void


class UserService {
    static func getUserInfos(query: String, header: HTTPHeaders, callback: @escaping CallbackUserInfos) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
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
    static func getOneFiles(query: String, header: HTTPHeaders, callback: @escaping CallbackUserFile) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserFile.self, from: data)
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
    static func getFiles(query: String, header: HTTPHeaders, callback: @escaping CallbackUserFiles) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserFiles.self, from: data)
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
    static func postUserInfos(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackUserEdition) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserInfos.self, from: data)
                    callback(result, nil)
                } catch let error {
                    print("Erreur de parsing", error)
                    callback(nil, error)
                }
            case .failure(let error) :
                print("Erreur de la requête")
                callback(nil, error)
            }
        }
    }
}
