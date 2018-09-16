//
//  MovieResultsDataObject.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

/// Data Model for Search Results TVC
struct MovieResultsDataObject {
    var title:String?
    var rating:Double?
    var language:String?
    var isAdult:Bool?
    var releaseDate:String?
    var overview:String?
    var posterImageURL:URL?
}
