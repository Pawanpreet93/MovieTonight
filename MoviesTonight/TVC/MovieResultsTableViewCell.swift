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

    private let labelCornerRadius: CGFloat = 10.0
    
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            self.roundedView.layer.cornerRadius = 12
            self.roundedView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.shadowColor = UIColor.black.cgColor
            self.containerView.layer.shadowOpacity = 0.3;
            self.containerView.layer.shadowRadius = 3.0;
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
            self.containerView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            self.posterImageView.layer.cornerRadius = 2.0
            self.posterImageView.clipsToBounds = true
        }
    }

    @IBOutlet weak var movieTitleLabel: HeaderLabel!
    @IBOutlet weak var ratingLabel: SmallHeaderLabel! {
        didSet {
            self.ratingLabel.layer.cornerRadius = labelCornerRadius
            self.ratingLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var languageLabel: SmallHeaderLabel! {
        didSet {
            self.languageLabel.layer.cornerRadius = labelCornerRadius
            self.languageLabel.clipsToBounds = true
            self.languageLabel.backgroundColor = UIColor.init(hex: Colors.languageTag.rawValue)
        }
    }
    
    @IBOutlet weak var adultLabel: SmallHeaderLabel! {
        didSet {
            self.adultLabel.layer.cornerRadius = labelCornerRadius
            self.adultLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var releaseDateLabel: VerySmallHeaderLabel!
    @IBOutlet weak var calenderIcon: UIImageView!
    @IBOutlet weak var overviewLabel: VerySmallHeaderLabel!
    
    func configureCell(withObject object:MovieResultsDataObject) {
        
        self.posterImageView.sd_setImage(with: object.posterImageURL, placeholderImage: Assets.placeholder.rawValue)
        
        movieTitleLabel.text = object.title
        
        ratingLabel.backgroundColor = RatingColorsHelper.getRatingColor(from: object.rating)
        
        if let rating = object.rating {
            ratingLabel.text = "\(rating)"
        } else {
            ratingLabel.text = "-"
        }
        
        if let language = object.language {
            languageLabel.text = "\(language)"
        } else {
            languageLabel.text = "-"
        }
        
        if let isAdult = object.isAdult {
            if isAdult {
                adultLabel.text = "A"
                adultLabel.backgroundColor = UIColor(hex: Colors.adultTag.rawValue)
            } else {
                adultLabel.text = "U/A"
                adultLabel.backgroundColor = UIColor(hex: Colors.anyAgeTag.rawValue)
            }
        } else {
            adultLabel.text = "-"
        }
        
        if let releaseDate = object.releaseDate {
            releaseDateLabel.text = releaseDate
            calenderIcon.isHidden = false
        } else {
            calenderIcon.isHidden = true
            releaseDateLabel.text = nil
        }
        
        overviewLabel.text = object.overview
        
    }
    
}
