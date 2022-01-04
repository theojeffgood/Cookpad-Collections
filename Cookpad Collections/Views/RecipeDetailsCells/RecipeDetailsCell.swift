//
//  RecipeTitleCell.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

class RecipeDetailsCell: UICollectionViewCell, SelfConfiguringCell {
   static var reuseIdentifier = K.CellIdentifiers.recipeDetailsCellIdentifier
   
   //SOLUTION FOR WordWrapTextViewLabel INSTEAD OF UILABEL IS DUE TO FUCKED WORD-WRAP BEHAVIOR FROM APPLE IMPLEMENTED IN IOS11. IT WAS ADAPTED FROM STACKOVERFLOW: https://stackoverflow.com/a/56871964/13551385
   let recipeTitle = WordWrapTextViewLabel()
   
   func configure(with recipeDataPoint: String) {
         setupCustomTextView()
      self.recipeTitle.backgroundColor = nil
         self.recipeTitle.text = recipeDataPoint
//         self.recipeTitle.font = UIFont(name: K.BrandFonts.recipeTitleMediumFont, size: 22)
//      self.recipeTitle.textColor = .black
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

//SOLUTION FOR WordWrapTextViewLabel INSTEAD OF UILABEL IS DUE TO FUCKED WORD-WRAP BEHAVIOR FROM APPLE IMPLEMENTED IN IOS11. IT WAS ADAPTED FROM STACKOVERFLOW: https://stackoverflow.com/a/56871964/13551385
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

