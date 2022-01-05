//
//  CustomNavBar.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

class CustomNavBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   func setTransparentNavBar(){
      self.navigationBar.setBackgroundImage(UIImage(), for: .default)
      self.navigationBar.shadowImage = UIImage()
//      self.navigationBar.isTranslucent = true
      self.navigationBar.barStyle = .black
      self.navigationBar.tintColor = .white
   }
   
   func setOpaqueNavBar(){
      self.navigationBar.barStyle = .default
      self.navigationBar.shadowImage = nil
      self.navigationBar.setBackgroundImage(nil, for: .default)
      self.navigationBar.tintColor = .black
   }
}
