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
	private let session = URLSession.shared

	fileprivate func printError(_ error: Error, _ data: Data?) {
		print(error)
		if let errorData = data {
			print(errorData)
		}
	}

	func searchMovie(byName movieName: String, completionHandler: @escaping ([Movie]) -> Void) {
		if let urlEncondedMovieQuery = movieName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			if let url = URL(string: "\(baseUrl)?apikey=\(apiKey)&s=\(urlEncondedMovieQuery)") {
				session.dataTask(with: url) { (data, response, error) in
					if let error = error {
						self.printError(error, data)
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

	func fillRaminFildsOf(_ movie: Movie, onFill: @escaping (Movie) -> Void) {
		if let url = URL(string: "\(baseUrl)?apikey=\(apiKey)&i=\(movie.id)") {
			session.dataTask(with: url) { (data, response, error) in
				if let error = error {
					self.printError(error, data)
					return
				}

				if let movieData = data {
					if let json = try? JSONSerialization.jsonObject(with: movieData, options: .mutableContainers) as? [String: Any] {
						let fullMovie = Movie(fromJson: json!)
						DispatchQueue.main.async { onFill(fullMovie) }
					}
				}
			}.resume()
		}
	}
}
