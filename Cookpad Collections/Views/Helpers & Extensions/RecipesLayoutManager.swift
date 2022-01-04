//
//  RecipesLayoutManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

//MARK: -- Layout for the Recipe Collections List

class RecipesLayoutManager{
   
   func getRecipeCollectionsLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
            return self.createRecipeCollectionsLayout()
      }
      return layout
   }
   
   private func createRecipeCollectionsLayout() -> NSCollectionLayoutSection {
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



//MARK: -- Layout for the Recipes List
   
extension RecipesLayoutManager{
   
   func getRecipesLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
            return self.createRecipesLayout()
      }
      return layout
   }
   
   private func createRecipesLayout() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(235))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(235))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: 2)
      layoutGroup.interItemSpacing = .fixed(8)

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.interGroupSpacing = 25
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10)

      return layoutSection
   }

}



//MARK: -- Layout for the Recipe Details experience

extension RecipesLayoutManager{
   
   func createCompositionalLayout(withTopHeight topHeight: CGFloat) -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
         guard let self = self else { return nil }
         let section = RecipeDetailsViewController.Section.allCases[sectionIndex]
         
         switch section {
         case .title:
            return self.createTitleSection(topHeight: topHeight)
         case .facts:
            return self.createFactsSection()
         case .ingredients:
            return self.createIngredientsSection()
         case .steps:
            return self.createStepsSection()
         }
      }
      layout.register(RecipeDetailsBackgroundView.self, forDecorationViewOfKind: "background")
      return layout
   }
   
   private func createTitleSection(topHeight: CGFloat) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 0, trailing: 15)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: topHeight, leading: 0, bottom: 0, trailing: 0)
      
      let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
      layoutSection.decorationItems = [backgroundItem]
      
      return layoutSection
   }
   
   private func createFactsSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 75, trailing: 0)
      
      let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
      backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
      layoutSection.decorationItems = [backgroundItem]
      
      return layoutSection
   }
   
   private func createIngredientsSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(650))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
      layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 20)
      layoutSection.interGroupSpacing = 15
      
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
      
      return layoutSection
   }
   
   private func createStepsSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(295))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
      layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 0)
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 50, trailing: 10)
      layoutSection.interGroupSpacing = 30
      
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
      
      return layoutSection
   }
   
   private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
      let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return layoutSectionHeader
   }
}
