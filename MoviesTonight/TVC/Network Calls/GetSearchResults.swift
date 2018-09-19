//
//  GetSearchResults.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

class GetSearchResults {
    
    func fetchResults(for query:String, pageNumber: Int, fetchRequestCompletionHandler: @escaping (_ status:RequestCompletionStates, _ response: SearchResultsDataModel?) -> Void) {
        
        let queryParams = ["query" : query, "page" : "\(pageNumber)"]
        
        APIManager.getData(withAPIEndpoint: .searchMovies, params: queryParams) { (status, responseData) in
            if responseData != nil {
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: responseData!)
                    let dataModel = self.parseMovieObjects(for: results)
                    fetchRequestCompletionHandler(.success, dataModel)
                }
                catch {
                    print("Error info: \(error)")
                    fetchRequestCompletionHandler(status, nil)
                    return
                }
            } else {
                fetchRequestCompletionHandler(status, nil)
            }
        }
        
    }
    
    private func parseMovieObjects(for object:MovieResults) -> SearchResultsDataModel {
        
        var dataModel = SearchResultsDataModel()
        var metaData = SearchResultsMetaData()
        
        metaData.pageNumber = object.page
        metaData.totalPages = object.totalPages
        metaData.totalResults = object.totalResults
        
        dataModel.metaData = metaData
        
        var movieResults = [MovieResultsDataObject]()
        
        //Creating Table View Cell Data Objects
        //We can skip this if we know we have to stay with same data source forever. If the data source/type can change, we should better convert it to view model. So that if we switch to XML or Proto from JSON, we can just change this.
        if let results = object.results {
            for eachResult in results {
                var tvcTableViewModel = MovieResultsDataObject()
                tvcTableViewModel.title = eachResult.title
                tvcTableViewModel.releaseDate = TimeHelper.convertStringDate(date: eachResult.releaseDate, of: "yyyy-MM-dd", to: "MMM d, yyyy")
                tvcTableViewModel.isAdult = eachResult.adult
                tvcTableViewModel.language = eachResult.originalLanguage
                tvcTableViewModel.overview = eachResult.overview
                tvcTableViewModel.posterImageURL = URL(string: NetworkStatics.imageBaseURL.rawValue + (eachResult.posterPath ?? ""))
                tvcTableViewModel.rating = eachResult.voteAverage
                
                movieResults.append(tvcTableViewModel)
            }
        }
        
        dataModel.results = movieResults
     
        return dataModel
    }
    
}
