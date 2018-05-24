//  UploadImageViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 08/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class UploadImageViewController: UIViewController {
  
  @IBOutlet weak var mainImageIvew: UIImageView!
  @IBOutlet weak var pickImageBtn: UIButton!
  @IBOutlet weak var goNextStepBtn: UIButton!
  @IBOutlet weak var nameForImageTextFd: UITextField!
  
  
  let pickerVC = UIImagePickerController()
  let storage: StorageReference! = Storage.storage().reference().child("PostImages")
  var downloadImageUrl: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem?.isEnabled = false
    checkIfTheresImageAndNameOfImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func pickImage(_ sender: Any) {
    goPickImage()
  }
  
  @IBAction func goNextStep(_ sender: UIButton) {
    post()
    performSegue(withIdentifier: "goToFinishUploadVC", sender: nil)
  }
  
}

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, FetchImageUrlProtocol {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    var selectedImageFromPicker: UIImage?
    
    if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      selectedImageFromPicker = editedImage }
    else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      selectedImageFromPicker = originalImage
    }
    if let selectedImage = selectedImageFromPicker {
      mainImageIvew.image = selectedImage
    }
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    print("Picking image canceled")
    dismiss(animated: true, completion: nil)
  }
  
  func goPickImage() {
    pickerVC.delegate = self
    pickerVC.allowsEditing = true
    present(pickerVC, animated: true, completion: nil)
  }
  
  func post() {
    // upload image to Firebase Storage:
    if mainImageIvew.image != nil {
      let uploadData = UIImageJPEGRepresentation(mainImageIvew.image!, 0.1) // compress image

      storage.child(nameForImageTextFd.text!).putData(uploadData!, metadata: nil, completion: ({ (metadata, error) in
        if error != nil {
          print("upload image error is \(error!)")
          return
        } else {
          print(metadata)
          self.storage.child(self.nameForImageTextFd.text!).downloadURL(completion: { (url, err) in
            if err != nil {
              
            } else {
              self.downloadImageUrl = String(url!.absoluteString)
            }
          })
        }
      }))
    }
    checkIfTheresImageAndNameOfImage()
  }
  // remove this all: use delegate from UploadFinishVC to fetch image URL here
  func fetchImageUrl() -> String {
    return downloadImageUrl!
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard  segue.identifier != nil else{ return }
    let destinationVC = segue.destination as! UploadFinishPageViewController
    destinationVC.delegate = self
  }
  
  func checkIfTheresImageAndNameOfImage() {
    if mainImageIvew.image != nil && nameForImageTextFd.text != "" {
      self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
  }
  
}




