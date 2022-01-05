//
//  RecipeCollectionCell.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/3/22.
//

import UIKit

class RecipeCollectionCell: UICollectionViewCell {
   static let reuseIdentifier = K.CellIdentifiers.recipeCollectionsCellIdentifier
   
   @IBOutlet weak var recipeCollectionImage: UIImageView!
   @IBOutlet weak var recipeCollectionTitle: UILabel!
   @IBOutlet weak var recipeCollectionDescription: UILabel!
   
   override func prepareForReuse() {
      super.prepareForReuse()
      recipeCollectionTitle.text?.removeAll()
      recipeCollectionDescription.text?.removeAll()
      recipeCollectionImage.image = nil
   }
}

//MARK:-- CELL CONFIGURATION

extension RecipeCollectionCell {
   func configure(title: String, description: String) {
      self.recipeCollectionTitle?.text = title
      self.recipeCollectionDescription?.text = description
   }
}

// MARK: - Shadows & Styles

extension RecipeCollectionCell {
   
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
