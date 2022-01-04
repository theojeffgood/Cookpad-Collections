//
//  Constants.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/3/22.
//

import Foundation

struct K {
   
   struct CellIdentifiers {
      static let recipeCollectionsCellIdentifier    = "recipeCollectionsCellIdentifier"
      static let recipesCellIdentifier              = "recipesCellIdentifier"
      static let recipeDetailsCellIdentifier        = "recipeDetailsCellIdentifier"
      static let recipeDetailsHeaderIdentifier      = "recipeDetailsHeaderIdentifier"
   }
   
   struct ViewControllerSegues {
      static let showReipces         = "showRecipesSegue"
      static let showRecipeDetails   = "showRecipeDetailsSegue"
   }
   
   struct ErrorMessages{
      static let noRecipeStep     = "Sorry there was an issue loading this step"
   }
}
