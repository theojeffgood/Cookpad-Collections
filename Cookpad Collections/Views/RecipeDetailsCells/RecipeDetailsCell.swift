//
//  RecipeTitleCell.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

class RecipeDetailsCell: UICollectionViewCell {
   static var reuseIdentifier = K.CellIdentifiers.recipeDetailsCellIdentifier
   
   // Using WordWrapTextViewLabel instead of UILabel in order to overcome default iOS behavior that awkwardly wraps text to avoid lines with only one word. That's not a concern for this app.
   // Solution was adapted from StackOverflow: https://stackoverflow.com/a/56871964/13551385
   let recipeTitle = WordWrapTextViewLabel()
   
   override func prepareForReuse() {
      super.prepareForReuse()
      recipeTitle.text.removeAll()
   }
   
   func setupCustomTextView(){
      recipeTitle.translatesAutoresizingMaskIntoConstraints = false
      addSubview(recipeTitle)
      NSLayoutConstraint.activate([
         recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
         recipeTitle.topAnchor.constraint(equalTo: topAnchor),
         recipeTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
         recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
   }
}

//Different configure methods are used depending on the purpose of the cell.
extension RecipeDetailsCell{
   
   func configureTitle(forTitle title: String) {
      setupCustomTextView()
      self.recipeTitle.backgroundColor = nil
      self.recipeTitle.text = title
      self.recipeTitle.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
   }
   
   func configureFacts(forFact fact: String) {
      setupCustomTextView()
      self.recipeTitle.backgroundColor = nil
      self.recipeTitle.text = "🧑🏾‍🍳 Recipe by: "
      self.recipeTitle.text.append(fact)
      self.recipeTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
   }
   
   func configureIngredients(forIngredient ingredient: String) {
      setupCustomTextView()
      self.recipeTitle.backgroundColor = nil
      self.recipeTitle.text = ingredient
      self.recipeTitle.font = UIFont.systemFont(ofSize: 20)
   }
   
   func configureSteps(forStep step: String, stepId: Int? = nil) {
      guard let stepId = stepId else { recipeTitle.text = K.ErrorMessages.noRecipeStep; return }
      setupCustomTextView()
      self.recipeTitle.backgroundColor = nil
      self.recipeTitle.text = "\(stepId)  -   "
      self.recipeTitle.text.append(step)
      self.recipeTitle.font = UIFont.systemFont(ofSize: 20)
   }
}

// Using WordWrapTextViewLabel instead of UILabel in order to overcome default iOS behavior that awkwardly wraps text to avoid lines with only one word. That's not a concern for this app.
// Solution was adapted from StackOverflow: https://stackoverflow.com/a/56871964/13551385
class WordWrapTextViewLabel: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() -> Void {
        isScrollEnabled = false
        isEditable = false
        isSelectable = false
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

