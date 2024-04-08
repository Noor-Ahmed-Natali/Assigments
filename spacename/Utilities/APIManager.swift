//
//  APIManager.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation
import Alamofire


class APIManager {

    private let que = DispatchQueue(label: "com.api", qos: .userInitiated)
    
    static let shared: APIManager = APIManager()
    private var headers: HTTPHeaders = []
    
    private init() {
        
    }
    
    
    func baseRequest<T: Codable>(route: String, method: HTTPMethod, headers: HTTPHeaders = [], extendedUrl: String? = nil,
                                 params: [String:Any]? = nil, type: T.Type) async -> Result<T?, ApiError> {
        await withCheckedContinuation { task in
            self.baseRequest(route: route, method: method, headers: headers, extendedUrl: extendedUrl, params: params, type: type) { result in
                switch result {
                case .success(let success):
                    return task.resume(returning: .success(success))
                case .failure(let failure):
                    return task.resume(returning: .failure(failure))
                }
            }
        }
    }
    
    
    
    
    func baseRequest<T: Codable>(route: String, method: HTTPMethod = .get, headers: HTTPHeaders = [], extendedUrl: String? = nil,
                                 params: [String:Any]? = nil, type: T.Type, block: @escaping (Result<T?, ApiError>) -> Void) {
        
//        let baseURL = Config.enviroment.serverUrl
//        let strURL = (baseURL+api.rawValue + (extendedUrl ?? "")).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if !headers.isEmpty {
            for (key, value) in headers.dictionary {
                self.headers[key] = value
            }
        }
        
        guard let url: URL = URL(string: route) else { block(.failure(.notURL)); return } // Error Not url
//        BaseModel<T>.self
        AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: self.headers)
            .responseDecodable(of: BaseModel<T>.self, queue: self.que) { result in
                let str = result.data?.prettyPrintedJSONString
                print(str)
                switch result.result {
                case .success(let success):
                    guard let data = success.data else { block(.failure(.noData)); return }
                    block(.success(data))
                case .failure(let error):
                    block(.failure(.AFError(error)))
                }
            }
    }
}


enum ApiError: Error {
    case notURL
    case noData
    case AFError(AFError)
}


