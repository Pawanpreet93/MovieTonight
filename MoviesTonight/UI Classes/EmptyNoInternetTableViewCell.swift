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

class EmptyNoInternetTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateText: SmallHeaderLabel!
    
    var delegate:EmptyStateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setState(state:EmptyCellStates) {
        switch state {
        case .noData:
            stateText.text = getString(for: Strings.noData.rawValue)
            stateImage.image = UIImage(named: "noData")
        case .noInternet:
            stateText.text = getString(for: Strings.noInternet.rawValue)
            stateImage.image = UIImage(named: "noInternet")
        }
    }
    
    
}
