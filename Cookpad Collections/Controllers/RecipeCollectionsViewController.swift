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
   typealias DataSource = UICollectionViewDiffableDataSource<Section, RecipeCollection>
   typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RecipeCollection>
   enum Section{
      case main
   }
   private lazy var dataSource = makeDataSource()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupRecipeCollectionsList()
      loadRecipeCollections()
   }
   
   private func setupRecipeCollectionsList() {
      recipeCollectionsList.delegate = self
      recipeCollectionsList.collectionViewLayout = RecipesLayoutManager().getRecipesLayout()
   }
   
   private func loadRecipeCollections(){
      recipeManager.downloadDataFromCloud(of: RecipeCollection.self){ [weak self] recipeCollections in
         guard let self = self else { return }
         self.displayRecipeCollections(recipeCollections)
      }
   }

}

extension RecipeCollectionsViewController{
   func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: recipeCollectionsList, cellProvider: { (collectionView, indexPath, recipeCollection) -> UICollectionViewCell? in

         let recipeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellIdentifiers.recipeCollectionsCellIdentifier, for: indexPath) as? RecipeCollectionCell

         recipeCollectionCell?.configure(with: recipeCollection)
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
      
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      guard let recipeCardViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeCardViewController else { return }
//
//      let imageRequest = ImageRequest(url: URL(string: selectedRecipe.imageUrl)!, processors: NukeManager.shared.resizedImageProcessors)
//      Nuke.loadImage(with: imageRequest, into: recipeCardViewController.recipeHeaderImageView)
//
//      self.navigationController?.pushViewController(recipeCardViewController, animated: true)
   }

}

extension RecipeCollectionsViewController: RecipeManagerProtocol{
   func setRecipeManager(recipeManager: RecipeManager) {
      self.recipeManager = recipeManager
   }
}




class RecipesLayoutManager{
   
   func getRecipesLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
            return self.createLayout()
      }
      return layout
   }
   
   func createLayout() -> NSCollectionLayoutSection {
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
