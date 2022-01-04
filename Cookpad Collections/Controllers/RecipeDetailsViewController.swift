//
//  RecipeDetailsViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/2/22.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

   @IBOutlet weak var recipeDetailsList: UICollectionView!
   
   typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
   typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
   private lazy var dataSource = makeDataSource()
   var layoutManager: RecipesLayoutManager!
   enum Section: String, CaseIterable {
      case title
      case facts
      case ingredients = "INGREDIENTS"
      case steps = "STEPS"
   }
   let recipeHeaderImageView = UIImageView()
   var recipeHeaderImageHeight: CGFloat{
      return view.frame.size.height / 2
   }
   var usersRecipe: Recipe?
   var totalTopArea: CGFloat = 0
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupRecipeImage()
      setupRecipeDetailsList()
      displayRecipeDetails()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      guard let customNavBarController = navigationController as? CustomNavBarController else { return }
      customNavBarController.setTransparentNavBar()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      if let safeUsersRecipe = usersRecipe{
         setupTitleView(safeUsersRecipe)
      }
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      guard let customNavBarController = navigationController as? CustomNavBarController else { return }
      customNavBarController.setOpaqueNavBar()
   }
      
//MARK: -- view functionality
   
   private func setupRecipeDetailsList() {
      recipeDetailsList.delegate = self
      recipeDetailsList.register(RecipeDetailsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecipeDetailsSectionHeader.reuseIdentifier)
//      layoutManager = RecipeDetailsLayoutManager(topArea: recipeHeaderImageHeight)
      recipeDetailsList.collectionViewLayout = layoutManager.createCompositionalLayout(withTopHeight: recipeHeaderImageHeight)
   }
   
   private func getDeviceMargins() {
      let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
      totalTopArea = safeAreaTop + 60 + (navigationController?.navigationBar.frame.height ?? 0)
   }
   
   private func setupRecipeImage() {
      getDeviceMargins()
      recipeHeaderImageView.contentMode = .scaleAspectFill
      recipeHeaderImageView.clipsToBounds = true
      recipeHeaderImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: recipeHeaderImageHeight)
      view.addSubview(recipeHeaderImageView)
      setupGradientView()
   }
   
   private func setupGradientView(){
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
      gradientLayer.locations = [0,0.2]
      recipeHeaderImageView.layer.addSublayer(gradientLayer)
      gradientLayer.frame = recipeHeaderImageView.bounds
   }
   
   func setupTitleView(_ safeUsersRecipe: Recipe) {
      let titleView = UILabel()
      titleView.text = safeUsersRecipe.title
      titleView.textColor = .white
      titleView.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
      titleView.alpha = 0
      navigationItem.titleView = titleView
   }
   
//MARK: -- RecipeCard CollectionView methods
   
   func makeDataSource() -> DataSource{
      let dataSource = DataSource(collectionView: recipeDetailsList, cellProvider: { collectionView, indexPath, string in

         guard let recipeDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailsCell.reuseIdentifier, for: indexPath) as? RecipeDetailsCell else { return UICollectionViewCell() }
         
         let recipeDetailsSection = Section.allCases[indexPath.section]
         switch recipeDetailsSection {
         case .title:
            recipeDetailsCell.configureTitle(forTitle: string)
         case .facts:
            recipeDetailsCell.configureFacts(forFact: string)
         case .ingredients:
            recipeDetailsCell.configureIngredients(forIngredient: string)
         case .steps:
            let stepId = indexPath.item + 1
            recipeDetailsCell.configureSteps(forStep: string, stepId: stepId)
         }
         
         return recipeDetailsCell
      })
      
      dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
         guard kind == UICollectionView.elementKindSectionHeader,
               let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: RecipeDetailsSectionHeader.reuseIdentifier,
                  for: indexPath) as? RecipeDetailsSectionHeader else { return nil }
         sectionHeader.sectionTitle.text = Section.allCases[indexPath.section].rawValue
         return sectionHeader
      }
      return dataSource
   }
   
   func displayRecipeDetails() {
//      recipeCardCollectionView.resetEmptyState()
      guard let safeUsersRecipe = usersRecipe else { return }
      var snapshot = Snapshot()
      
      let safeFacts = safeUsersRecipe.user.name
      let safeIngredients = safeUsersRecipe.ingredients
      let safeSteps = safeUsersRecipe.steps
      
      snapshot.appendSections(Section.allCases)
      snapshot.appendItems([safeUsersRecipe.title], toSection: .title)
      snapshot.appendItems([safeFacts], toSection: .facts)
      snapshot.appendItems(safeIngredients, toSection: .ingredients)
      snapshot.appendItems(safeSteps.map{ $0.description }, toSection: .steps)
      
      dataSource.apply(snapshot, animatingDifferences: true)
   }
}

extension RecipeDetailsViewController: UICollectionViewDelegate {

   //Scrroll offset is used to dynamically resize recipe image header, and set nav title accordingly
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let y = -(scrollView.contentOffset.y)
      if abs(y) > view.frame.height{
         return
      }
      let height = max(y + recipeHeaderImageHeight, totalTopArea)
      recipeHeaderImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
      let newButtonTitle = height < (totalTopArea + 35) ? " " : "Recipes"
      navigationController?.setBackButtonTitle(to: newButtonTitle)
      
      let dynamicAlpha: CGFloat = 1 + ((totalTopArea - recipeHeaderImageView.frame.height) / totalTopArea)
      navigationItem.titleView?.alpha = dynamicAlpha
   }
}
