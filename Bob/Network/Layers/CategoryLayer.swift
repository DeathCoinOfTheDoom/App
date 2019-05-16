import Foundation
import Alamofire
import AlamofireImage


typealias CallbackAllCategory = (_ categories: [CategoryData], _ error: Error?) -> Void
typealias CallbackDetailsCategory = (_ categories: [CategoryDetailsData], _ error: Error?) -> Void

class CategoryService {
    static func all(query: String, header: HTTPHeaders, callback: @escaping CallbackAllCategory) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(Category.self, from: data)
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
    static func details(query: String, header: HTTPHeaders, callback: @escaping CallbackDetailsCategory) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.request(url, method: .get, headers: header).responseData() { (response) in
            switch response.result {
            case .success(let data) :
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode(CategoryDetails.self, from: data)
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
