//
//  Strings.swift
//  MoviesTonight
//
//  Created by Pawan on 14/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

enum Strings : String {
    case searchMovies = "SEARCH_MOVIES"
}

/// To get localized string for the specific key
func getString(for key:String, and comment:String? = "") -> String {
    return NSLocalizedString(key, comment: comment ?? "")
}
