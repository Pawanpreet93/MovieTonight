//
//  Time.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation

enum TimeHelper {
    static func convertStringDate(date: String?, of fromFormat:String, to toFormat:String) -> String? {
        
        if date == nil {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        if let dateObject = dateFormatter.date(from: date!) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: dateObject)
        }
        
        return nil
    }
}
