import Foundation
import Alamofire

typealias CallbackPostImage = () -> Void

class FilesService {
    static func postImage(query: String, imageData: Data?, payload: Parameters, header: HTTPHeaders,  callback: @escaping CallbackPostImage) {
        let url = UrlBuilder.searchUrl(query: query)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in payload {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData {
                multipartFormData.append(data, withName: "file_input", fileName: "testSatan.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded", response)
                    if let err = response.error{
                        print("err", err)
                        return
                    }
                    callback()
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
}
