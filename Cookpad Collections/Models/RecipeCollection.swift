//
//  RecipeCollection.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Foundation

struct RecipeCollection: Decodable, Hashable, Identifiable {
   
   var id: Int
   var title: String
   var description: String
   var recipe_count: Int
   var preview_image_urls: [String]
   
   private enum CodingKeys: String, CodingKey {
      case id = "id",
           title = "title",
           description = "description" ,
           recipe_count = "recipe_count",
           preview_image_urls = "preview_image_urls"
   }

   init(from decoder: Decoder) throws {

      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decode(Int.self, forKey: .id)
      title = try container.decode(String.self, forKey: .title)
      description = try container.decode(String.self, forKey: .description)
      recipe_count = try container.decode(Int.self, forKey: .recipe_count)
      
      // Looks like images are sometimes empty. This is a quick fix to avoid displaying empty images
      preview_image_urls = try container.decode(Array<String>?.self, forKey: .preview_image_urls) ?? ["Recipe Placeholder"]
   }
}
