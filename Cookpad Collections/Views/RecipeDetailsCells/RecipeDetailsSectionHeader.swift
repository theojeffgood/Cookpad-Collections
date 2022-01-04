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
      sectionTitle.font = UIFont.systemFont(ofSize: 26, weight: .medium)
      sectionTitle.textAlignment = .left
      addSubview(sectionTitle)
      
      NSLayoutConstraint.activate([
         sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
         sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
         sectionTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
      ])
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("Stop trying to make storyboards happen.")
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      sectionTitle.text?.removeAll()
   }
}
