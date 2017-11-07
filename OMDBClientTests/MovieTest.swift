//
//  MovieTest.swift
//  OMDBClientTests
//
//  Created by Wesley Viana on 11/3/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import XCTest
@testable import OMDBClient

class MovieTest: XCTestCase {
    
    func testInitWithParametersNoCover() {
        let movie = Movie(named: "Matrix", releasedIn: 1999, withMainActor: "Keano", durring: "120 min")
		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)
		XCTAssertEqual("Keano", movie.mainActor)
		XCTAssertEqual("120 min", movie.duration)
		XCTAssertNil(movie.coverUrl)
    }

	func testInitWithParameters() {
		let movie = Movie(named: "Matrix", releasedIn: 1999, withMainActor: "Keano", durring: "120 min",
						  withCoverUrl: URL(string: "https://someurl.com/coverimage.jpg"))
		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)
		XCTAssertEqual("Keano", movie.mainActor)
		XCTAssertEqual("120 min", movie.duration)
		XCTAssertEqual("https://someurl.com/coverimage.jpg", movie.coverUrl?.absoluteString)
	}

	func testInitWithJsonTitleAndYear() {
		let json: [String: Any] = ["Title": "Matrix", "Year": 1999]

		let movie = Movie(fromJson: json)

		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)

		XCTAssertNil(movie.mainActor)
		XCTAssertNil(movie.duration)
		XCTAssertNil(movie.coverUrl)
	}
}
