//  RootViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 05/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit

class RootViewController: UIViewController {

  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var mainTitleLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    mainTitleLabel.adjustsFontSizeToFitWidth = true
    subTitleLabel.adjustsFontSizeToFitWidth = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
