//
//  RecipeListViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/2/22.
//

import UIKit

class RecipeListViewController: UIViewController {

   @IBOutlet weak var recipesList: UICollectionView!
   var recipes: [Recipe]?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }

}
