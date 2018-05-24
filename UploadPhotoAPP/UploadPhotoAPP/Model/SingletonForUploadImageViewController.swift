//
//  SingletonForUploadImageViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 12/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
  static let sharedInstance = Singleton()
  var uploadImageViewController: UploadImageViewController {
    get{
      if self.uploadImageViewController == nil {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.uploadImageViewController = (storyboard.instantiateViewController(withIdentifier: "UploadImageVC") as? UploadImageViewController)!
      }
      return self.uploadImageViewController
    }
    set {
      //error: uploadImageViewController is a get-only property
    }
  }
}
