//
//  Colors.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

enum Colors: String {
    case background = "#EAEAEA"
    case adultTag = "#F9627D"
    case anyAgeTag = "#F78764"
    case languageTag = "#307DF6"
}

let colorsCount = 9

enum RatingColorsHelper {
    
    
    ///All set of Rating Colors
    static func getRatingColors() -> [String] {
        return ["#cd1c26","#de1d0f","#ff7800","#ffba00","#cdd614","#9acd32","#5ba829","#3f7e00","#305d02"]
    }
    
    ///Get nearest rating index
    static func getRatingColorIndex(forRating rating: Double) -> Int {
        let ratings = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
        var index: Int = 0
        for i in 0..<colorsCount - 1 {
            if rating >= Double(ratings[i]) && rating < Double(ratings[i + 1]) {
                index = i
                break
            }
        }
        if rating == 5 {
            index = colorsCount - 1
        }
        return index
    }
    
    ///Get Rating color for Average Votes
    static func getRatingColor(from rating: Double?) -> UIColor? {
        var color: UIColor? = UIColor(hex: "#b9bfc7") //Default Gray Color
        guard let rating = rating else {
            return color
        }
        
        let index = self.getRatingColorIndex(forRating: rating/2)
        if rating >= 1 {
            color = UIColor.init(hex: RatingColorsHelper.getRatingColors()[index])
        }
        return color
    }
 

}
