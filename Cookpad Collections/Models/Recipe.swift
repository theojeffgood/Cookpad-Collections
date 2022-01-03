//
//  Recipe.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

struct Recipe: Decodable {
   var id: Int
   var title: String
   var story: String
   var image_url: String
   var published_at: String
   var user: User
   var ingredients: [String]
   var steps: [RecipeStep]
   
//   private enum CodingKeys: String, CodingKey {
//      case recipeId = "recipeId", title = "title", imageUrl = "imageUrl"
//   }
//
//   init(from decoder: Decoder) throws {
//      self.init()
//
//      let container = try decoder.container(keyedBy: CodingKeys.self)
//      id = try container.decode(Int.self, forKey: .recipeId)
//      title = try container.decode(String.self, forKey: .title)
//      imageUrl = try container.decode(String.self, forKey: .imageUrl)
//   }
}

struct User: Decodable{
   
}

struct RecipeStep: Decodable{
   
}
