//
//  NukeManager.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import Nuke

// Nuke is a third party library for loading images. Chosen for its ease of use, and small footprint.
// Details available at https://kean.blog/nuke/home

class NukeManager{
   
   static let shared = NukeManager()
   
   var resizedImageProcessors: [ImageProcessing] {
      let imageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
      return [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
   }
   
   func setupImageLoadingConfig() {
      DataLoader.sharedUrlCache.diskCapacity = 0
      let pipeline = ImagePipeline {
         let dataCache = try? DataCache(name: "com.cookpad-collections.recipe-photos.datacache")
         dataCache?.sizeLimit = 500 * 1024 * 1024
         $0.dataCache = dataCache
         
         $0.isProgressiveDecodingEnabled = true
         $0.isStoringPreviewsInMemoryCache = false
      }
      ImagePipeline.shared = pipeline
      
      let contentModes = ImageLoadingOptions.ContentModes(
        success: .scaleAspectFill,
        failure: .scaleAspectFill,
        placeholder: .scaleAspectFill)

      ImageLoadingOptions.shared.contentModes = contentModes
      ImageLoadingOptions.shared.placeholder = UIImage(named: "Recipe Placeholder")
      ImageLoadingOptions.shared.failureImage = UIImage(named: "Recipe Image Failure")
      ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.3)
   }
}
