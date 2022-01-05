//
//  RecipeCollectionsViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 12/31/21.
//

import UIKit
import Nuke

class RecipeCollectionsViewController: UIViewController {

   @IBOutlet weak var recipeCollectionsList: UICollectionView!
   private var recipeManager: RecipeManager!
   typealias DataSource = UICollectionViewDiffableDataSource<Section, RecipeCollection>
   typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RecipeCollection>
   enum Section{
      case main
   }
   private lazy var dataSource = makeDataSource()
   private var layoutManager = RecipesLayoutManager()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupRecipeCollectionsList()
      loadRecipeCollections()
   }
   		
   private func setupRecipeCollectionsList() {
      recipeCollectionsList.delegate = self
      recipeCollectionsList.collectionViewLayout = layoutManager.getRecipeCollectionsLayout()
   }
}

extension RecipeCollectionsViewController{
   private func loadRecipeCollections(){
      recipeManager.downloadDataFromCloud(of: RecipeCollection.self){ [weak self] recipeCollections in
         guard let self = self else { return }
         
         let loadingViewController = LoadingViewController()
         self.add(loadingViewController) // Display loading spinner
         
         self.displayRecipeCollections(recipeCollections)
         
         loadingViewController.remove() // Stop & remove loading spinner
      }
   }
   
   func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: recipeCollectionsList, cellProvider: { (collectionView, indexPath, recipeCollection) -> UICollectionViewCell? in

         guard let recipeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionCell.reuseIdentifier, for: indexPath) as? RecipeCollectionCell else { return UICollectionViewCell() }

         let imageRequest = ImageRequest(url: URL(string: recipeCollection.preview_image_urls.first ?? "Recipe Placeholder"), processors: NukeManager.shared.resizedImageProcessors)
         Nuke.loadImage(with: imageRequest, into: recipeCollectionCell.recipeCollectionImage)
         recipeCollectionCell.configure(title: recipeCollection.title, description: recipeCollection.description)
         
         recipeCollectionCell.shadowDecorate()
         return recipeCollectionCell
      })
      return dataSource
   }

   func displayRecipeCollections(_ recipeCollections: [RecipeCollection]) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(recipeCollections, toSection: .main)
      DispatchQueue.main.async {
         self.dataSource.apply(snapshot, animatingDifferences: true)
      }
//      showEmptyStateIfNeeded(snapshot: snapshot)
   }
}

extension RecipeCollectionsViewController: UICollectionViewDelegate{
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      collectionView.deselectItem(at: indexPath, animated: true)
      guard let recipeCollection = dataSource.itemIdentifier(for: indexPath) else { return }
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let recipeListViewController = storyboard.instantiateViewController(withIdentifier: "recipeListViewController") as? RecipeListViewController else { return }

      recipeListViewController.configureCriticalDependencies(layoutManager: layoutManager,
                                                             recipeManager: recipeManager,
                                                             selectedRecipeCollection: recipeCollection.id)

      self.navigationController?.pushViewController(recipeListViewController, animated: true)
   }
}

//MARK: -- Dependency injecting the model controller, recipeManager

extension RecipeCollectionsViewController: RecipeManagerProtocol{
   func setRecipeManager(recipeManager: RecipeManager) {
      self.recipeManager = recipeManager
   }
}


