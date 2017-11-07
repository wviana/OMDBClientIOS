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
		let movie = Movie(withId: "t123", named: "Matrix", releasedIn: 1999, withMainActor: "Keano", durring: "120 min")

		XCTAssertEqual("t123", movie.id)
		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)
		XCTAssertEqual("Keano", movie.mainActor)
		XCTAssertEqual("120 min", movie.duration)
		XCTAssertTrue(movie.isComplete)
		XCTAssertNil(movie.coverUrl)
    }

	func testInitWithParameters() {
		let movie = Movie(withId: "t123", named: "Matrix", releasedIn: 1999, withMainActor: "Keano", durring: "120 min",
						  withCoverUrl: URL(string: "https://someurl.com/coverimage.jpg"))

		XCTAssertEqual("t123", movie.id)
		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)
		XCTAssertEqual("Keano", movie.mainActor)
		XCTAssertEqual("120 min", movie.duration)
		XCTAssertEqual("https://someurl.com/coverimage.jpg", movie.coverUrl?.absoluteString)
		XCTAssertTrue(movie.isComplete)
	}

	func testInitWithJsonTitleAndYear() {
		let json: [String: Any] = ["Title": "Matrix", "Year": "1999", "imdbID": "t123"]

		let movie = Movie(fromJson: json)

		XCTAssertEqual("t123", movie.id)
		XCTAssertEqual("Matrix", movie.name)
		XCTAssertEqual(1999, movie.year)
		XCTAssertFalse(movie.isComplete)

		XCTAssertNil(movie.mainActor)
		XCTAssertNil(movie.duration)
		XCTAssertNil(movie.coverUrl)
	}
}
