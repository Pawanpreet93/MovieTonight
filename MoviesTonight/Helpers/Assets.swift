//
//  Assets.swift
//  MoviesTonight
//
//  Created by Pawan on 16/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

enum Assets {
    case placeholder
}

extension Assets: RawRepresentable {
    
    typealias RawValue = UIImage?
    
    init?(rawValue: UIImage?) {
        return nil
    }
    
    var rawValue: RawValue {
        switch self {
        case .placeholder: return UIImage(named: "placeholder")
        }
    }
}
