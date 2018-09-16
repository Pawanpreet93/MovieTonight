//
//  Fonts.swift
//  MoviesTonight
//
//  Created by Pawan on 13/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import UIKit

let systemRegularFont = UIFont.preferredFont(forTextStyle: .body)
let systemBoldFont = UIFont.preferredFont(forTextStyle: .title1)

let bodyFont = systemRegularFont.withSize(14)
let regularSmallFont = systemRegularFont.withSize(12)
let regularBigFont = systemRegularFont.withSize(18)
let bodyBoldFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .title3).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 14)
let smallBodyFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .title3).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 11)

let headerFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .title2).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
let mediumBoldFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .title2).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 18)
let smallHeaderFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .title2).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 12)
let verySmallHeaderFont = UIFont(descriptor: UIFont.preferredFont(forTextStyle: .caption1).fontDescriptor.withSymbolicTraits(.traitBold)!, size: 9)
