//
//  RecipeCollection.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Foundation

struct RecipeCollection: Decodable {
   
   var id: Int
   var title: String
   var description: String
   var recipe_count: Int
   var preview_image_urls: [String]
   
//   private enum CodingKeys: String, CodingKey {
//      case recipeId = "recipeId", title = "title", imageUrl = "imageUrl"
//   }
//
//   init(from decoder: Decoder) throws {
//      self.init()
//
//      let container = try decoder.container(keyedBy: CodingKeys.self)
//      recipeId = try container.decode(Int.self, forKey: .recipeId)
//      title = try container.decode(String.self, forKey: .title)
//      imageUrl = try container.decode(String.self, forKey: .imageUrl)
//   }
}
