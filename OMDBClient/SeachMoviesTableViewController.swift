//
//  SeachMoviesTableViewController.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/31/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import UIKit

class SeachMoviesTableViewController: UITableViewController, UITextFieldDelegate {

	@IBOutlet weak var seachTextField: UITextField!
	private var movies: [Movie] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	override func viewDidLoad() {
		seachTextField.delegate = self
	}

	var search: String = "" {
		didSet {
			OmdbService().searchMovie(byName: search) { self.movies = $0 }
		}
	}

	// MARK: - Seach TextField Delagate

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		search = textField.text ?? ""
		return false
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

	private var selectedMovie: Movie?

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedMovie = movies[indexPath.row]
		self.dismiss(animated: true)
		self.presentingViewController?.dismiss(animated: true)
	}

	// MARK: - Navigation

	override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
		if let myMoviesController = subsequentVC as? MyMoviesTableViewController {
			if let movie = selectedMovie {
				myMoviesController.myMovies.append(movie)
			}
		}

	}

}
