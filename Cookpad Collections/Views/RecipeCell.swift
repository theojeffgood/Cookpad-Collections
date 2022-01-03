//
//  RecipeCell.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/3/22.
//

import UIKit

class RecipeCell: UICollectionViewCell {
   static let reuseIdentifier = K.CellIdentifiers.recipesCellIdentifier
   
   @IBOutlet weak var recipeImage: UIImageView!
   @IBOutlet weak var recipeTitle: UILabel!
   
   override func prepareForReuse() {
      super.prepareForReuse()
      recipeImage.image = nil
   }
}

//MARK:-- CELL CONFIGURATION

//extension RecipeCell {
//   func configure(with recipe: Recipe) {
//      self.recipeTitleLabel?.text = recipe.title
//   }
//}

// MARK: - Shadows & Styles

extension RecipeCell {
   
   func shadowDecorate() {
      let radius: CGFloat = 5
//      self.recipeTitleView.layer.masksToBounds = true
      self.layer.masksToBounds = true
      
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: 1)
      self.layer.shadowRadius = 3.0
      self.layer.shadowOpacity = 0.5
      self.layer.masksToBounds = false
      self.layer.cornerRadius = radius
   }
}
