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
      navigationController?.setBackButtonTitle(to: "Cuisines")
      setupRecipesList()
      loadRecipes()
   }
   
   func configureCriticalDependencies(layoutManager: RecipesLayoutManager,
                                      recipeManager: RecipeManager,
                                      selectedRecipeCollection: RecipeCollection.ID){
      self.layoutManager = layoutManager
      self.recipeManager = recipeManager
      self.selectedRecipeCollection = selectedRecipeCollection
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
         
         let loadingViewController = LoadingViewController()
         self.add(loadingViewController) // Display loading spinner
         
         self.navigationItem.title = "\(recipes.count) Recipes"
         self.displayRecipes(recipes)
         
         loadingViewController.remove() // Stop & remove loading spinner
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
      collectionView.deselectItem(at: indexPath, animated: true)
      guard let selectedRecipe = dataSource.itemIdentifier(for: indexPath) else { return }
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let recipeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "recipeDetailsViewController") as? RecipeDetailsViewController else { return }

      if !selectedRecipe.image_url.isEmpty{
         let imageRequest = ImageRequest(url: URL(string: selectedRecipe.image_url)!, processors: NukeManager.shared.resizedImageProcessors)
         Nuke.loadImage(with: imageRequest, into: recipeDetailsViewController.recipeHeaderImageView)
      } else{
         recipeDetailsViewController.recipeHeaderImageView.image = UIImage(named: "Recipe Placeholder")
      }
      
      recipeDetailsViewController.layoutManager = self.layoutManager
      recipeDetailsViewController.usersRecipe = selectedRecipe

      self.navigationController?.pushViewController(recipeDetailsViewController, animated: true)
   }
}
