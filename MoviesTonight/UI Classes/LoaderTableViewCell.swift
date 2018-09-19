//
//  LoaderTableViewCell.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

class LoaderTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
