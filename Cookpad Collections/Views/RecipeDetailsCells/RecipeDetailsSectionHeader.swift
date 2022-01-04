//
//  RecipeDetailsSectionHeader.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

class RecipeDetailsSectionHeader: UICollectionReusableView {
   static let reuseIdentifier = K.CellIdentifiers.recipeDetailsHeaderIdentifier
   
   let sectionTitle = UILabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      sectionTitle.translatesAutoresizingMaskIntoConstraints = false
      sectionTitle.textColor = .label
//      sectionTitle.font = UIFont(name: K.BrandFonts.bodyRegularFont, size: 24)
      sectionTitle.textAlignment = .left
      addSubview(sectionTitle)
      
      NSLayoutConstraint.activate([
         sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
         sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
         sectionTitle.topAnchor.constraint(equalTo: topAnchor),
         sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("Stop trying to make storyboards happen.")
   }
}
