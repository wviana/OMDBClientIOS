//
//  Movie.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/30/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import Foundation

class Movie {
	let id: String
	let name: String
	let year: Int?
	let mainActor: String?
	let duration: String?
	let coverUrl: URL?

	init(withId id: String, named name: String, releasedIn year: Int,
		 withMainActor mainActor: String? = nil, durring duration: String? = nil, withCoverUrl coverUrl: URL? = nil
	) {
		self.id = id
		self.name = name
		self.year = year
		self.mainActor = mainActor
		self.duration = duration
		self.coverUrl = coverUrl
	}

	init(fromJson json: [String: Any]) {
		id = json["imdbID"] as! String
		name = json["Title"] as! String
		year = Int(json["Year"] as! String)

		if let actors = json["Actors"] as? String, let mainActor = actors.components(separatedBy: ",").first {
			self.mainActor = mainActor
		} else {
			mainActor = nil
		}

		if let duration = json["Runtime"] as? String {
			self.duration = duration
		} else {
			duration = nil
		}

		if let url = json["Poster"] as? String {
			coverUrl = URL(string: url)
		} else {
			coverUrl = nil
		}
	}

	var isComplete: Bool {
		get {
			return mainActor != nil && duration != nil
		}
	}
}
