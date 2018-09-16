//
//  SearchResultsDataModel.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

struct SearchResultsDataModel {
    var metaData:SearchResultsMetaData?
    var results:[MovieResultsDataObject]?
}


struct SearchResultsMetaData {
    var pageNumber:Int?
    var totalResults:Int?
    var totalPages:Int?
}
