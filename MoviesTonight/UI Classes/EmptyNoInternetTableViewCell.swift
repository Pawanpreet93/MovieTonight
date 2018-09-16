//
//  EmptyNoInternetTableViewCell.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

enum EmptyCellStates {
    case noInternet
    case noData
}

protocol EmptyStateDelegate {
    func didTapRetryButton()
}

class EmptyNoInternetTableViewCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateText: SmallHeaderLabel!
    @IBOutlet weak var retryButton: UIButton!{
        didSet{
            retryButton.titleLabel?.font = bodyBoldFont
        }
    }
    
    var delegate:EmptyStateDelegate?
    
    func setState(state:EmptyCellStates) {
        switch state {
        case .noData:
            stateText.text = "No Data Found"
            stateImage.image = UIImage(named: "noData")
            retryButton.isHidden = true
        case .noInternet:
            stateText.text = "No Internet"
            stateImage.image = UIImage(named: "noInternet")
            retryButton.isHidden = false
        }
    }
    
    @IBAction func retry(_ sender: Any) {
        delegate?.didTapRetryButton()
    }
    
    
}
