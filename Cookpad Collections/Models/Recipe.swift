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
   
   private enum CodingKeys: String, CodingKey {
      case id = "id",
           title = "title",
           story = "story" ,
           image_url = "image_url",
           published_at = "published_at",
           user = "user",
           ingredients = "ingredients",
           steps = "steps"
   }

   init(from decoder: Decoder) throws {

      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decode(Int.self, forKey: .id)
      title = try container.decode(String.self, forKey: .title)
      story = try container.decode(String.self, forKey: .story)
      published_at = try container.decode(String.self, forKey: .published_at)
      user = try container.decode(User.self, forKey: .user)
      steps = try container.decode(Array<RecipeStep>.self, forKey: .steps)
      
      // Looks like images are sometimes empty. This is a quick fix to avoid displaying empty images
      image_url = try container.decode(String?.self, forKey: .image_url) ?? ""
      
      // Looks like ingredients are sometimes duplicates. This is a quick fix to remove dupes.
      let uncleanIngredientsList = try container.decode(Array<String>.self, forKey: .ingredients)
      ingredients = Array(Set(uncleanIngredientsList))
   }
}

extension Recipe: Hashable{
   static func == (lhs: Recipe, rhs: Recipe) -> Bool {
      return lhs.id == rhs.id
   }
   
   func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
}





struct User: Decodable{
   var name: String
   var image_url: String
}

struct RecipeStep: Decodable{
   var description: String
   var image_urls: [String]
}
