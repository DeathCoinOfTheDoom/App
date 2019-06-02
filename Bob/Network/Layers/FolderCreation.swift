import Foundation
import Alamofire

typealias CallbackCreateFolder =  (_ folder: FolderCreationData?, _ error: Error?) -> Void

class FolderService {
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
}
