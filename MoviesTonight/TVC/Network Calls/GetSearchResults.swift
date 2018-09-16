//
//  GetSearchResults.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

class GetSearchResults {
    
    func fetchResults(for query:String, pageNumber: Int, fetchRequestCompletionHandler: @escaping (_ status:RequestCompletionStates, _ response: MovieResults?) -> Void) {
        
        let queryParams = ["query" : query, "page" : "\(pageNumber)"]
        
        APIManager.getData(withAPIEndpoint: .searchMovies, params: queryParams) { (status, responseData) in
            if responseData != nil {
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: responseData!)
                    fetchRequestCompletionHandler(.success, results)
                }
                catch {
                    print("Error info: \(error)")
                    fetchRequestCompletionHandler(status, nil)
                    return
                }
            }
            fetchRequestCompletionHandler(status, nil)
        }
        
    }
    
}
