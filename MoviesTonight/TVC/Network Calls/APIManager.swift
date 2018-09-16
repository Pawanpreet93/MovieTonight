//
//  APIManager.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

//http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1

enum NetworkStatics : String {
    case apiKey = "2696829a81b1b5827d515ff121700838"
    case baseURL = "http://api.themoviedb.org/3"
}

enum APIEndpoints : String {
    case searchMovies = "/3/search/movie"
}

enum RequestCompletionStates {
    case loading
    case success
    case noInternet
    case noData
    case failed
}

enum APIManager {
    
    static func getData(withAPIEndpoint apiEndpoint: APIEndpoints, params: [String:String], fetchRequestCompletionHandler: @escaping (_ status:RequestCompletionStates, _ response: Data?) -> Void) {
        //[String: Any]?
        
        // Set up the URL request
        let apiURLCompnent = NSURLComponents(string: NetworkStatics.baseURL.rawValue)!
        apiURLCompnent.path = apiEndpoint.rawValue
        
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "api_key", value: NetworkStatics.apiKey.rawValue))
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            apiURLCompnent.queryItems = items
        }

        guard let url = apiURLCompnent.url else {
            print("Error creating URL")
            fetchRequestCompletionHandler(.failed, nil)
            return
        }
        
        print("API URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        //Set up URLSession
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Create the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print(error!)
                
                if let nsError = error as NSError? {
                    switch nsError.code {
                    case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
                        fetchRequestCompletionHandler(.noInternet, nil)
                    default:
                        fetchRequestCompletionHandler(.failed, nil)
                    }
                }
                
                fetchRequestCompletionHandler(.failed, nil)
                return
            }
            
            //Did we get the data ?
            guard let responseData = data else {
                print("Error: Did not Receive Data")
                fetchRequestCompletionHandler(.failed, nil)
                return
            }
            
            fetchRequestCompletionHandler(.success, responseData)

            // Parse the result as JSON
            // In case the response type changes, change the parsing technique
//            do {
//                guard let responseObject = try JSONSerialization.jsonObject(with: responseData, options: [])
//                    as? [String: Any] else {
//                        print("Error: Trying to convert data to JSON")
//                        fetchRequestCompletionHandler(.failed, nil)
//                        return
//                }
//
//
//            } catch  {
//                print("Error: Trying to convert data to JSON")
//                fetchRequestCompletionHandler(.failed, nil)
//                return
//            }
        }
        task.resume()
    }
}
