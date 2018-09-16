//
//  CachedSearchQueriesTableViewCell.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

class CachedSearchQueriesTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var searchTextLabel: UILabel!
    
    
    //Overriding function to give look and feel that cell is tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.searchTextLabel.alpha = 0.5
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.searchTextLabel.alpha = 1.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.searchTextLabel.alpha = 1.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.searchTextLabel.alpha = 1.0
    }
}
