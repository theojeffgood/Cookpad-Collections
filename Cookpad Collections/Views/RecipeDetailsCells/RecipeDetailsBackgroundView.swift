//
//  RecipeDetailsBackgroundView.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

class RecipeDetailsBackgroundView: UICollectionReusableView {
   
   let sectionColorView = UIView()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      sectionColorView.translatesAutoresizingMaskIntoConstraints = false
      sectionColorView.backgroundColor = UIColor.systemYellow
      addSubview(sectionColorView)
      
      NSLayoutConstraint.activate([
         sectionColorView.leadingAnchor.constraint(equalTo: leadingAnchor),
         sectionColorView.topAnchor.constraint(equalTo: topAnchor),
         sectionColorView.bottomAnchor.constraint(equalTo: bottomAnchor),
         sectionColorView.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

