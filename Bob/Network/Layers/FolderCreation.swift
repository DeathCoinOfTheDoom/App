import Foundation
import Alamofire

typealias CallbackCreateFolder =  (_ type: FolderCreation?, _ error: Error?) -> Void

class FolderService {
    static func creation(query: String, payload: Parameters, header: HTTPHeaders, callback: @escaping CallbackCreateFolder) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case .success :
                callback((response.value as! FolderCreation), nil)
            case .failure(let error) :
                callback(nil, error)
            }
        }
    }
}
