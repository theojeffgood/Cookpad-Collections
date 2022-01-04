//
//  RecipeListViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/2/22.
//

import UIKit
import Nuke

class RecipeListViewController: UIViewController {

   @IBOutlet weak var recipesList: UICollectionView!
//   var recipes: [Recipe]?
   var recipeManager: RecipeManager!
   var layoutManager: RecipesLayoutManager!
   var selectedRecipeCollection: RecipeCollection.ID?
   typealias DataSource = UICollectionViewDiffableDataSource<Section, Recipe>
   typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>
   enum Section{
      case main
   }
   private lazy var dataSource = makeDataSource()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupRecipesList()
      loadRecipes()
   }

   private func setupRecipesList() {
      recipesList.delegate = self
      recipesList.collectionViewLayout = layoutManager.getRecipesLayout()
   }
}

extension RecipeListViewController{
   private func loadRecipes(){
      guard let selectedRecipeCollection = selectedRecipeCollection else { return }
      recipeManager.downloadDataFromCloud(collectionId: selectedRecipeCollection, of: Recipe.self){ [weak self] recipes in
         guard let self = self else { return }
         
         self.navigationItem.title = "\(recipes.count) Recipes"
         self.displayRecipes(recipes)
      }
   }
   
   func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: recipesList, cellProvider: { (collectionView, indexPath, recipe) -> UICollectionViewCell? in

         guard let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else { return UICollectionViewCell() }

         let imageRequest = ImageRequest(url: URL(string: recipe.image_url), processors: NukeManager.shared.resizedImageProcessors)
         Nuke.loadImage(with: imageRequest, into: recipeCell.recipeImage)
         recipeCell.configure(with: recipe)
         
         recipeCell.shadowDecorate()
         return recipeCell
      })
      return dataSource
   }

   func displayRecipes(_ recipes: [Recipe]) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(recipes, toSection: .main)
      DispatchQueue.main.async {
         self.dataSource.apply(snapshot, animatingDifferences: true)
      }
//      showEmptyStateIfNeeded(snapshot: snapshot)
   }
}

extension RecipeListViewController: UICollectionViewDelegate{
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard let recipeCollection = dataSource.itemIdentifier(for: indexPath) else { return }
      
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      guard let recipeCardViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeCardViewController else { return }
//
//      let imageRequest = ImageRequest(url: URL(string: selectedRecipe.imageUrl)!, processors: NukeManager.shared.resizedImageProcessors)
//      Nuke.loadImage(with: imageRequest, into: recipeCardViewController.recipeHeaderImageView)
//
//      self.navigationController?.pushViewController(recipeCardViewController, animated: true)
   }
}
