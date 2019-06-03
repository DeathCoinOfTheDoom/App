import Foundation
import Alamofire

typealias CallbackCreateFolder =  (_ folder: FolderCreationData?, _ error: Error?) -> Void
typealias CallbackModificationFolder =  (_ folder: UserFolderData?, _ error: Error?) -> Void
typealias CallbackListingFolders = (_ userFolder: [UserFolderData], _ error: Error?) -> Void
typealias CallbackDeleteFolder =  () -> Void

class FolderService {
    static func listing(query: String, header: HTTPHeaders, callback: @escaping CallbackListingFolders) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserFolders.self, from: data)
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
    static func creation(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackCreateFolder) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseData() { response in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(FolderCreation.self, from: data)
                    callback(result.data, nil)
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
    static func modification(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackModificationFolder) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseData() { response in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(UserFolder.self, from: data)
                    callback(result.data, nil)
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
    static func delete(query: String, header: HTTPHeaders, callback: @escaping CallbackDeleteFolder) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: header).responseJSON() { response in
            switch response.result {
            case .success :
                callback()
            case .failure(let error) :
                print("error", error)
            }
        }
    }
}
