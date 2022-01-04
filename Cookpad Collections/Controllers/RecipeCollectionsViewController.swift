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
         self.displayRecipeCollections(recipeCollections)
      }
   }
   
   func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: recipeCollectionsList, cellProvider: { (collectionView, indexPath, recipeCollection) -> UICollectionViewCell? in

         guard let recipeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionCell.reuseIdentifier, for: indexPath) as? RecipeCollectionCell else { return UICollectionViewCell() }

         let imageRequest = ImageRequest(url: URL(string: recipeCollection.preview_image_urls.first ?? ""), processors: NukeManager.shared.resizedImageProcessors)
         Nuke.loadImage(with: imageRequest, into: recipeCollectionCell.recipeCollectionImage)
         recipeCollectionCell.configure(with: recipeCollection)
         
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
      guard let recipeCollection = dataSource.itemIdentifier(for: indexPath) else { return }
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      guard let recipeListViewController = storyboard.instantiateViewController(withIdentifier: "recipeListViewController") as? RecipeListViewController else { return }

//      let imageRequest = ImageRequest(url: URL(string: selectedRecipe.imageUrl)!, processors: NukeManager.shared.resizedImageProcessors)
//      Nuke.loadImage(with: imageRequest, into: recipeCardViewController.recipeHeaderImageView)
      recipeListViewController.recipeManager = self.recipeManager
      recipeListViewController.layoutManager = self.layoutManager
      recipeListViewController.selectedRecipeCollection = recipeCollection.id

      self.navigationController?.pushViewController(recipeListViewController, animated: true)
   }
}

extension RecipeCollectionsViewController: RecipeManagerProtocol{
   func setRecipeManager(recipeManager: RecipeManager) {
      self.recipeManager = recipeManager
   }
}



//MARK: -- Layout for Recipe Collections List

class RecipesLayoutManager{
   
   func getRecipeCollectionsLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
            return self.createRecipeCollectionsLayout()
      }
      return layout
   }
   
   func createRecipeCollectionsLayout() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(235))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(235))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
//      layoutGroup.interItemSpacing = .fixed(8)
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.interGroupSpacing = 12
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 10)
      layoutSection.orthogonalScrollingBehavior = .groupPaging

      return layoutSection
   }
}

//MARK: -- Layout for Recipes in a collection
   
extension RecipesLayoutManager{
   
   func getRecipesLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
            return self.createRecipesLayout()
      }
      return layout
   }
   
   func createRecipesLayout() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(235))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(235))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: 2)
      layoutGroup.interItemSpacing = .fixed(8)

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.interGroupSpacing = 20
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10)

      return layoutSection
   }

}
