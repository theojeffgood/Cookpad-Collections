//
//  RecipeCollectionsViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 12/31/21.
//

import UIKit

class RecipeCollectionsViewController: UIViewController {

   @IBOutlet weak var recipeCollectionsList: UICollectionView!
   private var recipeManager: RecipeManager!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      recipeManager.loadRecipes(of: RecipeCollection.self)
   }

}

extension RecipeCollectionsViewController: RecipeManagerProtocol{
   func setRecipeManager(recipeManager: RecipeManager) {
      self.recipeManager = recipeManager
   }
}
