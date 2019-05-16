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
typealias CallbackUserFiles = (_ userFiles: [UserFilesData], _ error: Error?) -> Void
typealias CallbackUserEdition = (_ user: User?, _ error: Error?) -> Void

typealias CallbackUserInfos = (_ userInfos: UserInfosData? , _ error: Error?) -> Void
typealias CallbackUpdateProfile = (_ userInfos: UserInfosData? , _ error: Error?) -> Void


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
    static func postUserInfos(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackUpdateProfile) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case .success :
                    print("c'est le succées")
//                callback(response.value as? Int, nil)
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
    static func postFiles(query: String, header: HTTPHeaders, callback: @escaping CallbackUserFiles, payload: UserPostFiles) {
        let url = UrlBuilder.searchUrl(query: query)
        if let imgData = payload.image.jpegData(compressionQuality: 0.2) {
             let parameters = ["userId": payload.userId, "file_type_id": payload.fileTypeId, "file_input": imgData] as [String : Any]
            Alamofire.upload(imgData, to: url, method: .post, headers: header)
            .uploadProgress {
                progress in print("the progress is", progress)
            }
            .responseJSON {
                response in print("the response is", response)
            }
        }
    }
    static func update(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackUserEdition) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(User.self, from: data)
                    print("result", result)
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
