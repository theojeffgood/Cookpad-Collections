//
//  UINavigationController + SetTitle.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

extension UINavigationController{
   var rootViewController: UIViewController? {
      return viewControllers.first
   }
   
   func setBackButtonTitle(to newTitle: String) {
      let backItem = UIBarButtonItem()
      backItem.title = newTitle
      let previousViewController = getPreviousViewController()
      previousViewController?.navigationItem.backBarButtonItem = backItem
   }
   
   func getPreviousViewController() -> UIViewController? {
      let count = viewControllers.count
      guard count > 1 else { return nil }
      return viewControllers[count - 2]
   }
}
