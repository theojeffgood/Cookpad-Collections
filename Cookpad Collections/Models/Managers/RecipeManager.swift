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
   
   var delegate: RecipeManagerProtocol?
   
   func downloadDataFromCloud<T: Decodable>(collectionId: Int? = nil, of Type: T.Type, completion: @escaping ([T]) -> Void){
      NetworkManager.shared.fetchFoodRecipeData(collectionId: collectionId, of: [T].self){ (response) in
         switch response {
         case .success(let recipesFromCloud):
            if !recipesFromCloud.isEmpty{
               completion(recipesFromCloud)
            }
            
         case .failure(let error):
            print("Failed to fetch recipes:", error)
         }
      }
   }
}
