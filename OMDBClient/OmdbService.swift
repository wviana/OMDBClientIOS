//
//  OmdbService.swift
//  OMDBClient
//
//  Created by Wesley Viana on 11/1/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import Foundation


class OmdbService {
	private let baseUrl = "https://www.omdbapi.com/"
	private let apiKey = "fc37e517"
	private let key = "BanMePlz"

	func searchMovie(byName movieName: String, completionHandler: @escaping ([Movie]) -> Void) {
		if let urlEncondedMovieQuery = movieName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			if let url = URL(string: "\(baseUrl)?apikey=\(apiKey)&s=\(urlEncondedMovieQuery)") {
				let session = URLSession.shared
				session.dataTask(with: url) { (data, response, error) in
					if let error = error {
						print(error)
						if let errorData = data {
							print(errorData)
						}
						return
					}

					if let moviesData = data {
						do {
							let json = try JSONSerialization.jsonObject(with: moviesData, options: .mutableContainers) as? [String: Any]

							if let moviesJsonArray = json?["Search"] as? [[String: Any]] {
								let movies = moviesJsonArray.map { Movie(fromJson: $0) }
								DispatchQueue.main.async {
									completionHandler(movies)
								}
							} else {
								print("Couldn't transform into Array of map")
							}
						} catch { }
					}

					}.resume()
			}
		}
	}
}
