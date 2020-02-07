//
//  MovieHomeViewModel.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

class MovieHomeViewModel {

    public enum homeError {
        case internetError(String)
        case serverMessage(String)
    }

    public var isLoading : ((Bool)->Void)?

    var movieList = [Movie]()

    var didUpdate: ((MovieHomeViewModel) -> Void)?

    public var onError : ((homeError)->Void)?

    let requestManager: RequestManager

    init(requestManager: RequestManager = RequestManager()) {
        self.requestManager = requestManager
    }

    public func requestData() {

        self.isLoading?(true)

        requestManager.getMovies { [weak self] result in

            guard let strongSelf = self else { return }
            strongSelf.isLoading?(false)

            switch result {
            case .success(let moviesResponse) :

                strongSelf.movieList = moviesResponse.results
                strongSelf.didUpdate?(strongSelf)

            case .failure(let failure) :

                switch failure {

                case .connectionError:
                    strongSelf.onError?(.internetError("Check your Internet connection."))

                case .authorizationError(let errorResponse):

                    strongSelf.onError?(.serverMessage(errorResponse.statusMessage))

                default:

                    strongSelf.onError?(.serverMessage("Unknown Error"))
                }
            }
        }
    }
}

