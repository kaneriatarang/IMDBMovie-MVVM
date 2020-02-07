//
//  RequestManager.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

class RequestManager {

// MARK: - Get Contacts

    typealias GetMovieResult = Result<MoviesResponse, RequestError>
    typealias GetMovieCompletion = (_ result: GetMovieResult) -> Void

    func getMovies(completion: @escaping GetMovieCompletion) {

        let apiManager = APIManager()

        let requestURL = "http://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=01"

        apiManager.requestData(isWithBaseUrl: false, url: requestURL, method: .get, parameters: nil, completion: { (result) in

            DispatchQueue.main.async {

                switch result {
                case .success(let responseData) :
                     do {

                    let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: responseData)
                    completion(.success(payload: moviesResponse))
                    }
                    catch let parseJSONError {
                        completion(.failure(.unknownError))
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }

                case .failure(let failure) :

                    completion(.failure(failure))

                }
            }
        })
    }

}

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

final class MockRequestManager: RequestManager {

    var getMovieResult: RequestManager.GetMovieResult?

    override func getMovies(completion: @escaping RequestManager.GetMovieCompletion) {
        completion(getMovieResult!)
    }

}
