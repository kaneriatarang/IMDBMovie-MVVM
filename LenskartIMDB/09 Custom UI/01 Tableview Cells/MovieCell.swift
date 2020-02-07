//
//  MovieCell.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!

    var movieData: Movie? {
        didSet {
            if let movie = movieData {
                titleLabel.text = movie.title
                overviewLabel.text = movie.overview
                movieImageView.sd_setImage(with: URL(string: movie.posterURLPath), placeholderImage: #imageLiteral(resourceName: "placeholder_photo"), options: SDWebImageOptions(rawValue: 0), completed: nil)

            }
        }

    }

    static var defaultIdentifier: String { return "MovieCell" }

}
