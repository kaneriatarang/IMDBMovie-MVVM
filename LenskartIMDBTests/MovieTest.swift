//
//  MovieTest.swift
//  LenskartIMDBTests
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import XCTest
@testable import LenskartIMDB

class MovieTest: XCTestCase {

    var jsonData: Data?

    override func setUp() {

        let testJSON : [String: Any] = [
            "popularity":19.622,
            "vote_count":5544,
            "video":false,
            "poster_path":"/u9qGMRwcPwP0WETxulS5hKUsEum.jpg",
            "id":9487,
            "adult":false,
            "backdrop_path":"/bHMHpXNjeKRxcjWcpbIAD5f0aIK.jpg",
            "original_language":"en",
            "original_title":"A Bug's Life","genre_ids":[12,16,35,10751],
            "title":"A Bug's Life","vote_average":6.9,
            "overview":"On behalf of \"oppressed bugs everywhere,\" an inventive ant named Flik hires a troupe of warrior bugs to defend his bustling colony from a horde of freeloading grasshoppers led by the evil-minded Hopper.",
            "release_date":"1998-11-25"]

        do {
            jsonData = try JSONSerialization.data(withJSONObject: testJSON, options: JSONSerialization.WritingOptions()) as Data
        } catch _ {
            print ("JSON Failure")
        }


    }

    override func tearDown() {

        jsonData = nil
    }

    func testmovieObjectParsing() {
        XCTAssertNotNil(Movie.init(data: jsonData!))
    }

}

extension Movie {
    static func with() -> Movie
    {

        return Movie(id: 10, voteCount: 554, popularity: 19.622, voteAverage: 6.9, video: false, adult: false, posterPath: "/u9qGMRwcPwP0WETxulS5hKUsEum.jpg", backdropPath: "/u9qGMRwcPwP0WETxulS5hKUsEum.jpg", originalLanguage: "En", originalTitle: "A Bug's Life", title: "A Bug's Life",
                     overview: "On behalf of \"oppressed bugs everywhere,\" an inventive ant named Flik hires a troupe of warrior bugs to defend his bustling colony from a horde of freeloading grasshoppers led by the evil-minded Hopper.", releaseDate: "1998-11-25", genreIds: [12,16,35,10751])
    }
}
