//
//  SearchResultsDataSource.swift
//  MoviesTonight
//
//  Created by Pawan on 14/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsDataSourceAndDelegate: NSObject,  UITableViewDataSource, UITableViewDelegate {
    
    var metaData = SearchResultsMetaData()
    var searchObjects = [MovieResultsDataObject]()
    var delegate:TableDataChange?
    var statusOfData: RequestCompletionStates = .loading
    var noMoreDataToLoad = false
    var isLoadingMoreData = false
    
    var query = ""
    
    func search(for text:String) {
        searchObjects.removeAll()
        metaData = SearchResultsMetaData()
        getData(for: text)
    }

    private func getData(for query:String) {
        
        self.query = query
        
        let object = GetSearchResults()
        
        statusOfData = .loading
        
        object.fetchResults(for: query, pageNumber: metaData.pageNumber ?? 1) { (status, resultObject) in
            
            self.statusOfData = status
            self.metaData = resultObject?.metaData ?? SearchResultsMetaData()
            
            self.isLoadingMoreData = false
            
            if resultObject?.metaData?.pageNumber == resultObject?.metaData?.totalPages {
                self.noMoreDataToLoad = true
            } else {
                self.noMoreDataToLoad = false
            }
            
            if let fetchedResults = resultObject?.results {
                self.searchObjects.append(contentsOf: fetchedResults)
            }
            
            if self.searchObjects.count == 0 && self.statusOfData == .success {
                self.statusOfData = .noData
            }
            
            if resultObject?.metaData?.pageNumber == 1 && self.searchObjects.count > 0{
                DBHelper.addQueryToDB(withText: query, completion: { (status) in
                })
            }
            
            DispatchQueue.main.sync {
                self.delegate?.reloadTableView()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch statusOfData {
        case .failed, .noData, .noInternet, .loading:
            return 1
            
        case .success:
            return searchObjects.count + (noMoreDataToLoad ? 0 : 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if statusOfData == .loading || (indexPath.row == searchObjects.count && isLoadingMoreData) {
            let cell:LoaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.contentView.backgroundColor = UIColor(hex: Colors.background.rawValue)
            return cell
        }
        
        if statusOfData != .success {
            let cell:EmptyNoInternetTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setState(state: statusOfData == .noInternet ? .noInternet : .noData)
            cell.delegate = self
            cell.contentView.backgroundColor = UIColor(hex: Colors.background.rawValue)
            return cell
        }
        
        let cell:MovieResultsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(withObject: searchObjects[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if searchObjects.count == 0 || noMoreDataToLoad {
            return
        }
        
        if indexPath.row == searchObjects.count - 1 && !isLoadingMoreData && statusOfData != .loading {
            isLoadingMoreData = true
            metaData.pageNumber = (metaData.pageNumber ?? 1) + 1
            getData(for: self.query)
        }
    }
    
}


extension SearchResultsDataSourceAndDelegate: EmptyStateDelegate {
    func didTapRetryButton() {
        if statusOfData != .loading {
            getData(for: self.query)
        }
    }
}
