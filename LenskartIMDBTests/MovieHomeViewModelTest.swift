//
//  MovieHomeViewModelTest.swift
//  LenskartIMDBTests
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import XCTest
@testable import LenskartIMDB

class MovieHomeViewModelTest: XCTestCase {

    var requestManager: MockRequestManager?

    override func setUp() {
        requestManager = MockRequestManager()
    }

    override func tearDown() {
        requestManager = nil
    }

    func testNormalGetMovie() {

        requestManager?.getMovieResult = .success(payload: [Movie.with()])

        let viewModel = MovieHomeViewModel(requestManager: requestManager!)
        viewModel.requestData()

        XCTAssert(viewModel.movieList.count == 1)

    }



}
