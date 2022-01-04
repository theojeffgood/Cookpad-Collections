//
//  RecipeDetailsLayoutManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

struct RecipeDetailsLayoutManager{
   
   let recipeDetailsList: UICollectionView
   let topArea: CGFloat
   
   init(recipeDetailsList: UICollectionView, topArea: CGFloat) {
      self.recipeDetailsList = recipeDetailsList
      self.topArea = topArea
   }
   
   func createCompositionalLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
         let section = RecipeDetailsViewController.Section.allCases[sectionIndex]
         
         switch section {
         case .title:
            return self.createTitleSection()
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
   
   func createTitleSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 0, trailing: 15)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: topArea, leading: 0, bottom: 0, trailing: 0)
      
      let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
      layoutSection.decorationItems = [backgroundItem]
      
      return layoutSection
   }
   
   func createFactsSection() -> NSCollectionLayoutSection {
      let recipeFactSize = recipeDetailsList.frame.width / 3
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(recipeFactSize), heightDimension: .fractionalHeight(1.0))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0)
      
      let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
      backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
      layoutSection.decorationItems = [backgroundItem]
      
      return layoutSection
   }
   
   func createIngredientsSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(650))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
      layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 10, trailing: 20)
      
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
      
      return layoutSection
   }
   
   func createStepsSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(295))
      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
      let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
      layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 0)

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 50, trailing: 10)
      layoutSection.interGroupSpacing = 30
      
      let layoutSectionHeader = createSectionHeader()
      layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
      
      return layoutSection
   }
   
   func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
      let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
      let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      return layoutSectionHeader
   }
}
