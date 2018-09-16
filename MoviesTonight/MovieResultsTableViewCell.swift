//
//  MovieResultsTableViewCell.swift
//  MoviesTonight
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieResultsTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: HeaderLabel!
    @IBOutlet weak var ratingLabel: RegularLabel!
    @IBOutlet weak var languageLabel: RegularLabel!
    @IBOutlet weak var adultLabel: RegularLabel!
    @IBOutlet weak var releaseDateLabel: VerySmallHeaderLabel!
    @IBOutlet weak var overviewLabel: VerySmallHeaderLabel!
    
    override func awakeFromNib() {
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.3;
        self.containerView.layer.shadowRadius = 3.0;
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.containerView.layer.masksToBounds = false
        self.roundedView.layer.cornerRadius = 12
        self.roundedView.clipsToBounds = true
        self.posterImageView.layer.cornerRadius = 8.0
        self.posterImageView.clipsToBounds = true
    }
    
    func configureCell(with dataObject: String) {
        
    }
    
}
