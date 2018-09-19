//
//  ViewController.swift
//  MoviesTonight
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

protocol TableDataChange {
    
    ///Reload table view
    ///Used specifically when data source/delegate has to be changed
    func reloadTableView()
    
    /// To get search results when cached query is selected from other data source
    func getSearchResults(forQuery query: String)
}

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // Search result lives here
    var searchResultsDataSourceAndDelegate = SearchResultsDataSourceAndDelegate()
    
    // Cached Search Queries lives here
    var savedQueriesDataSourceAndDelegate = SavedQueriesDataSourceAndDelegate()
    
    // Search Bar
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearch()
    }

    private func setupTableView() {
        
        //Register Cells
        tableView.register(cell: MovieResultsTableViewCell.self)
        tableView.register(cell: CachedSearchQueriesTableViewCell.self)
        tableView.register(cell: LoaderTableViewCell.self)
        tableView.register(cell: EmptyNoInternetTableViewCell.self)
        
        //Listener to handle data source refresh
        searchResultsDataSourceAndDelegate.delegate = self
        
        //Listener to handle cached query click
        savedQueriesDataSourceAndDelegate.delegate = self

        //To consolidate spacing between cells
        tableView.contentInset = UIEdgeInsets(top: 6.0, left: 0, bottom: 6.0, right: 0)
        
        //To make cards more prominent
        tableView.backgroundColor = UIColor.white
        
        //To hide empty cells
        tableView.tableFooterView = UIView()
        
        //Dismiss keyboard on drag
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func setupSearch() {
        searchController.searchBar.delegate = self
        
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        }
        
        searchController.searchBar.placeholder = getString(for: Strings.searchMovies.rawValue)
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Switching table view data source to empty
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            searchResults(forQuery: query)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        switchToSavedQueriesState()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //If search bar goes empty then show Cached data
        if searchBar.text?.isEmpty ?? false {
            switchToSavedQueriesState()
        }
    }
    
    private func searchResults(forQuery query:String) {
        // Switching table view data source to search data
        tableView.dataSource = searchResultsDataSourceAndDelegate
        tableView.delegate = searchResultsDataSourceAndDelegate
        
        //Ask Data Source to search data
        searchResultsDataSourceAndDelegate.search(for: query)
        
        //UI changes for search results
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: Colors.background.rawValue)
        tableView.reloadData()
    }
    
    private func switchToSavedQueriesState() {
        // Switching table view data source to cached data
        tableView.dataSource = savedQueriesDataSourceAndDelegate
        tableView.delegate = savedQueriesDataSourceAndDelegate
        
        //Ask Data Source to get cached data from Core data
        savedQueriesDataSourceAndDelegate.fetchQueries()
        
        //UI changes for queries
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.white
        tableView.reloadData()
    }
}

extension ViewController : TableDataChange {
   
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func getSearchResults(forQuery query: String) {
        //Adding cached string to search bar text
        searchController.searchBar.text = query
        
        //Get results
        searchResults(forQuery: query)
    }
    
    
}
