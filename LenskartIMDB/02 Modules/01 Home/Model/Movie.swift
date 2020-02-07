//
//  Movie.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    public let statusCode: Int
    public let statusMessage: String
    public let success: Bool
    public let errors: [String]

    enum CodingKeys: String, CodingKey {
        case success, errors
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable {

    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let releaseDate: String
    public let voteAverage: Double
    public let voteCount: Int
    public let genreIds: [Int]?
    public let adult: Bool
    let video: Bool
    let popularity: Double
    public let originalLanguage: String
    public let originalTitle: String

//       public var posterURL: URL {
//           return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
//       }
//
//       public var backdropURL: URL {
//           return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
//       }
//
//       public var voteAveragePercentText: String {
//           return "\(Int(voteAverage * 10))%"
//       }


    var posterURLPath: String { "http://image.tmdb.org/t/p/w92/" + (posterPath ?? "") }

    enum CodingKeys: String, CodingKey {
        case id, popularity, video, adult, title, overview
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}


// MARK: Convenience initializers
//
//extension Movie {
//
//    init?(data: Data) {
//        do {
//            let me = try JSONDecoder().decode(Movie.self, from: data)
//            self = me
//        }
//        catch {
//            print(error)
//            return nil
//        }
//    }
//
//}
