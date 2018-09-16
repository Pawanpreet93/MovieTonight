//
//  SearchResultsDataSource.swift
//  MoviesTonight
//
//  Created by Pawan on 14/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

protocol TableDataChange {
    func didChangeDataOfTable()
}

class SearchResultsDataSource: NSObject,  UITableViewDataSource {
    
    var metaData = SearchResultsMetaData()
    var searchObjects = [MovieResultsDataObject]()
    var delegate:TableDataChange?
    
    func getData(for query:String) {
        let object = GetSearchResults()
        
        searchObjects.removeAll()
        
        object.fetchResults(for: query, pageNumber: metaData.pageNumber ?? 1) { (status, resultObject) in
            
            self.metaData = resultObject?.metaData ?? SearchResultsMetaData()
            
            if let fetchedResults = resultObject?.results {
                self.searchObjects.append(contentsOf: fetchedResults)
            }
            
            DispatchQueue.main.sync {
                self.delegate?.didChangeDataOfTable()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieResultsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(withObject: searchObjects[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}

class SearchResultsDelegate: NSObject,  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
