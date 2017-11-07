//
//  MovieViewCell.swift
//  OMDBClient
//
//  Created by Wesley Viana on 10/31/17.
//  Copyright © 2017 wviana. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var mainActorLabel: UILabel!
	@IBOutlet weak var durationLabel: UILabel!

	var movie: Movie? { didSet { updateUI() } }

	private func updateUI() {
		titleLabel?.text = movie?.name
		if let year = movie?.year {
			yearLabel?.text = String(describing: year)
		} else {
			yearLabel?.text = "ND"
		}
		mainActorLabel?.text = movie?.mainActor
		durationLabel?.text = movie?.duration
	}

}
