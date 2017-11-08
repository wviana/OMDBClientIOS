//
//  MyMoviesTableViewController.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/30/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import UIKit

class MyMoviesTableViewController: UITableViewController, MovieSelectedDelegate {


	var myMovies = [Movie]()
	let service  = OmdbService()

	override func viewDidLoad() {
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMovies.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
		if let movieCell = cell as? MovieViewCell {
			movieCell.omdbServjce = service
			movieCell.movie = myMovies[indexPath.row]
		}
		return cell
	}

	// MARK: - Navegation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let smtvc = segue.destination as? SearchMoviesTableViewController {
			smtvc.delegate = self
			smtvc.omdbSerice = service
		}
	}

	// MARK: - SelectMovieDelegate

	func selectMovie(_ movie: Movie) {
		myMovies.append(movie)
		self.tableView.insertRows(at: [IndexPath(row: myMovies.count - 1, section: 0)], with: .automatic)
	}


}
