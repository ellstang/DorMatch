//  UploadImagePageViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 21/03/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase


class UploadFinishPageViewController: UIViewController {
  
  @IBOutlet weak var mainTitleTextFd: UITextField!
  @IBOutlet weak var subPostUserInfoTextFd: UITextField!
  @IBOutlet weak var houseDescriptionTextFd: UITextView!
  @IBOutlet weak var uploadBtn: UIButton!

  
  let pickerVC = UIImagePickerController()
  let storage: StorageReference! = Storage.storage().reference().child("PostImages")
  let database: DatabaseReference! = Database.database().reference(fromURL: "https://uploadphoto-7af69.firebaseio.com/Posts")
  
  // declare fetchImageUrlProtocol delegate:
  var delegate: FetchImageUrlProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func pickImage(_ sender: UIButton) {
    //post()
  }
  
  @IBAction func uploadIMG(_ sender: Any) {
    uploadTask()
    let alert = UIAlertController(title: "Cool", message: "Successed! You just post to the board!", preferredStyle: .alert)

    let alertMsg = UIAlertAction(title: "Perfect", style: .cancel) { (action) in
      self.navigationController?.popToRootViewController(animated: true)
    }
    alert.addAction(alertMsg)
    self.present(alert, animated: true, completion: nil)
    
  }
  
}


extension UploadFinishPageViewController {
  func uploadTask() {
    
    if mainTitleTextFd.text != "" && subPostUserInfoTextFd.text != "" && houseDescriptionTextFd.text != "" {
    // upload texts to Firebase database:
      postsStorageArray["postTitle"] = mainTitleTextFd.text! as AnyObject
      postsStorageArray["posterDescription"] = subPostUserInfoTextFd.text as AnyObject
      postsStorageArray["imageLongDescription"] = houseDescriptionTextFd.text as AnyObject
      postsStorageArray["imageURL"] = delegate?.fetchImageUrl() as AnyObject
      postsStorageArray["posterUserName"] = Auth.auth().currentUser?.displayName as AnyObject
      postsStorageArray["postUserID"] = Auth.auth().currentUser?.uid as AnyObject
      
      // create an instance of class "Post_ForTableView"
      let aPost_ForTableView = Post_ForTableView()
      aPost_ForTableView.postTitle = mainTitleTextFd.text
      aPost_ForTableView.posterDescription = subPostUserInfoTextFd.text
      aPost_ForTableView.postUserName = Auth.auth().currentUser?.displayName
      aPost_ForTableView.imageLongDescription = houseDescriptionTextFd.text
      aPost_ForTableView.imageURL = delegate?.fetchImageUrl()
      aPost_ForTableView.postUserUid = Auth.auth().currentUser?.uid
     
      // app will crash if the following line is added
      //aPost_ForTableView.setValuesForKeys(postsStorageArray)
      let postRef = database.childByAutoId()
      postRef.updateChildValues(postsStorageArray) { (error, databaseRef) in
        if error != nil {
          print("upload task failed with error: \(String(describing: error))")
        } else {
          //displayPost.append(aPost_ForTableView)
          //displayPost.insert(aPost_ForTableView, at: displayPost.count)
          print("upload task successed")}
      }
      
    }
  }
}

