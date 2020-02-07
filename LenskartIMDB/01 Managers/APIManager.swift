//
//  APIManager.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum ApiResult {
      case success(Data)
      case failure(RequestError)
}

enum RequestError: Error {
       case unknownError
       case connectionError
       case authorizationError(ErrorResponse)
       case invalidRequest
       case notFound
       case invalidResponse
       case serverError
       case serverUnavailable
}

class APIManager {

    typealias parameters = [String:Any]

    let baseUrl = ""

    func requestData(isWithBaseUrl: Bool = true, url: String, method: HTTPMethod, parameters: Data?, completion: @escaping (ApiResult)->Void) {

        let header =  ["Content-Type": "application/json"]

        var urlRequest = URLRequest(url: URL(string: isWithBaseUrl ? baseUrl+url : url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        if let parameter = parameters {
//            let parameterData = parameters.reduce("") { (result, param) -> String in
//                return result + "&\(param.key)=\(param.value as! String)"
//            }.data(using: .utf8)
            urlRequest.httpBody = parameter
        }

        print(urlRequest.cURL)

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(ApiResult.failure(.connectionError))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
//                    let responseJson = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                    let responseJson = try JSON(data: data)
                    print("responseCode : \(responseCode.statusCode)")
//                    print("responseJSON : \(responseJson)")
                    switch responseCode.statusCode {
                    case 200,201:
                    completion(ApiResult.success(data))
                    case 400...499:
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(ApiResult.failure(.authorizationError(errorResponse)))
                    case 500...599:
                    completion(ApiResult.failure(.serverError))
                    default:
                        completion(ApiResult.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(ApiResult.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
        }.resume()
    }
}


