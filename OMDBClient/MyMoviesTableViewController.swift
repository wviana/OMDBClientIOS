//
//  MyMoviesTableViewController.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/30/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import UIKit

class MyMoviesTableViewController: UITableViewController {

	var myMovies = [Movie]() {
		didSet {
			self.tableView.reloadData()
		}
	}

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
			movieCell.movie = myMovies[indexPath.row]
		}
		return cell
	}

	

}
