//
//  SeachMoviesTableViewController.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/31/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import UIKit

class SearchMoviesTableViewController: UITableViewController, UITextFieldDelegate {

	@IBOutlet weak var seachTextField: UITextField!
	private var movies: [Movie] = []

	override func viewDidLoad() {
		seachTextField.delegate = self
	}

	var omdbSerice: OmdbService?

	var search: String = "" {
		didSet {
			if let service = omdbSerice {
				service.searchMovie(byName: search) { self.movies = $0 }
			}
		}
	}

	// MARK: - Seach TextField Delagate

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		search = textField.text ?? ""
		return true
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTitleCell", for: indexPath)
		let movie = movies[indexPath.row]
		cell.textLabel?.text = movie.name
		if let movieYear = movie.year {
			cell.detailTextLabel?.text = String(describing: movieYear)
		} else {
			cell.detailTextLabel?.text = "ND"
		}
		return cell
    }

	weak var delegate: MovieSelectedDelegate?

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let delegate = self.delegate {
			delegate.selectMovie(movies[indexPath.row])
		}
		self.navigationController?.popViewController(animated: true)
	}
}

protocol MovieSelectedDelegate : class {
	func selectMovie(_ movie: Movie)
}
