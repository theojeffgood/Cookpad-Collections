//
//  RecipeManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Foundation

protocol RecipeManagerProtocol {
   
   func setRecipeManager(recipeManager: RecipeManager)
}

struct RecipeManager{
   
   func loadRecipes<T: Decodable>(collectionId: Int? = nil, of objectType: T.Type) -> [T]{
      switch objectType {
      case is Recipe.Type:
         guard let collectionId = collectionId else { return [] }
         downloadDataFromCloud(collectionId: collectionId, of: Recipe.self)
      case is RecipeCollection.Type:
         downloadDataFromCloud(of: RecipeCollection.self)
      default:
         return []
      }
      return []
   }
   
   func downloadDataFromCloud<T: Decodable>(collectionId: Int? = nil, of Type: T.Type) -> [T]{
      var dataFromCloud: [T] = []
      NetworkManager.shared.fetchFoodRecipeData(collectionId: collectionId, of: [T].self){ (response) in
         switch response {
         case .success(let recipesFromCloud):
            if !recipesFromCloud.isEmpty{
               dataFromCloud = recipesFromCloud
            }
         case .failure(let error):
            print("Failed to fetch recipes:", error)
         }
      }
      return dataFromCloud
   }
   
}
