//
//  MovieTests.swift
//  MoviesTests
//
//  Created by Neha Pant on 27/01/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import UIKit
import XCTest
@testable import Movies

class MoviesTest: XCTestCase {
    func testMovieData() {
        if let movie = MovieUtility().getMovieJSON() {
            XCTAssertEqual(movie.results.count, 1)
        }
    }
}
