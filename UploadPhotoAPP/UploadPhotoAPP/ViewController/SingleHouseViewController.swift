//s  SingleHouseViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 11/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class SingleHouseViewController: UIViewController {
  
  var delegate: GetSelectedCellInfoProtocol?

  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var postTitleLabel: UILabel!
  @IBOutlet weak var postDate: UILabel!
  @IBOutlet weak var longDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageURL =  URL(string: (delegate?.getCellInfo().imageURL)!)
    URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
      if error != nil {
        print("download image task error \(error)")
      } else {
        DispatchQueue.main.async {
          self.mainImage.image = UIImage(data: data!)
        }
      }
    }.resume()
    
    postTitleLabel.text = delegate?.getCellInfo().postTitle
    longDescription.text = delegate?.getCellInfo().imageLongDescription
    print(delegate?.getCellInfo().imageLongDescription)
    //print(delegate?.getCellInfo().postTitle ?? "Failed to fetch post info")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  @IBAction func goBack(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
//   performSegue(withIdentifier: "BackToRentCasesVC", sender: nil)
  }
  
  @IBAction func goChatWithPostUser(_ sender: UIButton) {
    self.performSegue(withIdentifier: "goSendMsgVC", sender: nil)
  }
  
}



