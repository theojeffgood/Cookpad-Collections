//
//  SelfConfiguringCell.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Foundation

protocol SelfConfiguringCell {
   static var reuseIdentifier: String { get }
   func configure(with recipeDataPoint: String)
}
