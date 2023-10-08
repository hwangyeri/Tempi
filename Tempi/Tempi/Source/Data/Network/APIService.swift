//
//  APIService.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/07.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func fetchDataFromGoogleSheet(completion: @escaping (Result<Category, Error>) -> Void ) {
    
        guard let url = URL(string: "https://opensheet.elk.sh/1qUmEhpIZGX0W8JxAGFBxecNrh7DYQAufrvDTxwWF298/1") else {
            completion(.failure(CommonErrors.invalidURL))
            return
        }
        
        AF.request(url).responseDecodable(of: Category.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
                print(result, "----- result End -----")
            case .failure(_):
                if let statusCode = response.response?.statusCode {
                    let statusCodeError = StatusCodeErrors(rawValue: statusCode)
                    completion(.failure(statusCodeError ?? CommonErrors.notVerifiedStatusCode))
                } else {
                    completion(.failure(CommonErrors.notVerifiedStatusCode))
                }
            }
        }
    }
}
