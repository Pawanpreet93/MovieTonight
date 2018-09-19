//
//  ViewController.swift
//  MoviesTonight
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // Search result lives here
    var searchResultsDataSourceAndDelegate = SearchResultsDataSourceAndDelegate()
    
    // Cached Search Queries lives here
    var savedQueriesDataSource = SavedQueriesDataSource()
    var savedQueriesDelegate = SavedQueriesDelegate()
    
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
        
        //To consolidate spacing between cells
        tableView.contentInset = UIEdgeInsets(top: 6.0, left: 0, bottom: 6.0, right: 0)
        
        //To make cards more prominent
        tableView.backgroundColor = UIColor.white
        
        //To hide empty cells
        tableView.tableFooterView = UIView()
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
        
        // Switching table view data source to search data
        tableView.dataSource = searchResultsDataSourceAndDelegate
        tableView.delegate = searchResultsDataSourceAndDelegate
        
        if let query = searchBar.text {
            searchResultsDataSourceAndDelegate.search(for: query)
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: Colors.background.rawValue)
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Switching table view data source to cached data
        tableView.dataSource = savedQueriesDataSource
        tableView.delegate = savedQueriesDelegate
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.white
        tableView.reloadData()
    }
}

extension ViewController : TableDataChange {
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
}
