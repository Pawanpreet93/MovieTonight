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
    var searchResultsDataSource = SearchResultsDataSource()
    var searchResultsDelegate = SearchResultsDelegate()
    var savedQueriesDataSource = SavedQueriesDataSource()
    var savedQueriesDelegate = SavedQueriesDelegate()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.register(cell: MovieResultsTableViewCell.self)
        tableView.dataSource = savedQueriesDataSource
        tableView.delegate = savedQueriesDelegate
        tableView.contentInset = UIEdgeInsets(top: 6.0, left: 0, bottom: 0, right: 0)

    }


}


extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.dataSource = savedQueriesDataSource
        tableView.delegate = savedQueriesDelegate
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.dataSource = searchResultsDataSource
        tableView.delegate = searchResultsDelegate
        tableView.reloadData()
    }
}
