//
//  SavedQueriesDataSource.swift
//  MoviesTonight
//
//  Created by Pawan on 14/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

class SavedQueriesDataSource: NSObject,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieResultsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movieTitleLabel.text = "Cached Movie Title"
        cell.selectionStyle = .none
        return cell
    }
    
}

class SavedQueriesDelegate: NSObject,  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
