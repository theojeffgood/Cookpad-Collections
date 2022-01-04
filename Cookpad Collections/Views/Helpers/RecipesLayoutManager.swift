//
//  RecipesLayoutManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

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
