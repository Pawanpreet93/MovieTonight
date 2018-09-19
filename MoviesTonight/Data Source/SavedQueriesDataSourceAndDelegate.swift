//
//  SavedQueriesDataSource.swift
//  MoviesTonight
//
//  Created by Pawan on 14/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

class SavedQueriesDataSourceAndDelegate: NSObject,  UITableViewDataSource, UITableViewDelegate {
    
    var cachedQueries = [String]()
    var delegate:TableDataChange?

    func fetchQueries() {
        cachedQueries = DBHelper.getCachedQueriesFromDB(withAscendingSorting: false) ?? [String]()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cachedQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CachedSearchQueriesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.searchTextLabel.text = cachedQueries[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getSearchResults(forQuery: cachedQueries[indexPath.row])
    }
    
}
