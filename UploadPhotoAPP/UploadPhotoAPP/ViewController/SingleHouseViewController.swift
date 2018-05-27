//s  SingleHouseViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 11/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class SingleHouseViewController: UIViewController {
  

  var post = Post_ForTableView()
  
  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var postTitleLabel: UILabel!
  @IBOutlet weak var postDate: UILabel!
  @IBOutlet weak var longDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let imageURL = URL(string: post.imageURL!)
    postTitleLabel.text = post.postTitle!
    longDescription.text = post.imageLongDescription

    URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
      if error != nil {
        print("download image task error \(error)")
      } else {
        DispatchQueue.main.async {
          self.mainImage.image = UIImage(data: data!)
        }
      }
    }.resume()

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  @IBAction func goChatWithPostUser(_ sender: UIButton) {
    self.performSegue(withIdentifier: "goSendMsgVC", sender: nil)
  }
  
}



