//
//  NetworkManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Foundation

struct NetworkManager {
   
   static let shared = NetworkManager()
   
   typealias ResultBlock<T> = (Result <T, Error>) -> Void
   let baseUrl = "https://cookpad.github.io/global-mobile-hiring"
   enum dataParameter: String{
      case collections = "/api/collections/" //get list of collections
      case recipes = "/recipes" //get list of recipes in a given collection
//      case recipeDetails = "/api/recipes/" //get details of a given recipes
   }
   
   func fetchFoodRecipeData<T: Decodable>(collectionId: Int? = nil,
                                          of type: T.Type,
                                          completion: @escaping ResultBlock<T>){
      var urlPath: String
      
      switch type {
      case is Array<Recipe>.Type:
         guard let collectionId = collectionId else { return }
         urlPath = dataParameter.collections.rawValue
         urlPath.append("\(collectionId)")
         urlPath.append(dataParameter.recipes.rawValue)
         
      case is Array<RecipeCollection>.Type:
         urlPath = dataParameter.collections.rawValue
         
      default:
         return
      }
      let urlString = "\(baseUrl)\(urlPath)"

      if let url = URL(string: urlString) {
         let session = URLSession(configuration: .default)
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         
         let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
               completion(.failure(error))
               return
            }
            DispatchQueue.main.async {
               do {
                  let items = try JSONDecoder().decode(T.self, from: data!)
                  completion(.success(items))
               } catch let jsonError {
                  completion(.failure(jsonError))
               }
            }
         }
         task.resume()
      }
   }
}
