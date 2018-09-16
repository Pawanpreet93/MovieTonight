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
    
    func getData() {
        let object = GetSearchResults()
        object.fetchResults(for: "batman", pageNumber: 1) { (status, resultObject) in
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieResultsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movieTitleLabel.text = "Cached Movie Title"
        
        var movieObject = MovieResultsDataObject()
        movieObject.posterImageURL = URL(string: "http://image.tmdb.org/t/p/w92/2DtPSyODKWXluIRV7PVru0SSzja.jpg")
        movieObject.title = "Dark Knight Rider"
        movieObject.rating = 9.0
        movieObject.language = "EN"
        movieObject.isAdult = false
        movieObject.releaseDate = "25 Oct 1993"
        movieObject.overview = "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld."
        
        cell.configureCell(withObject: movieObject)
        cell.selectionStyle = .none
        return cell
    }
    
}

class SavedQueriesDelegate: NSObject,  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
