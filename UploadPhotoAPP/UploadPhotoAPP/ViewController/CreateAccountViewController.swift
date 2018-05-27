//
//  CreateAccountViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 26/03/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountViewController: UIViewController {
  
  var handle: Bool = false
  
  @IBOutlet weak var enterUserNameTextFd: UITextField!
  @IBOutlet weak var enterEmailTextFd: UITextField!
  @IBOutlet weak var enterPsdTextFd: UITextField!
  @IBOutlet weak var confirmPsdTextFd: UITextField!
  @IBOutlet weak var sendFormBtn: UIButton!
  @IBOutlet weak var logInBtn: UIButton!
  @IBOutlet weak var goToUploadBtn: UIBarButtonItem!
  
  override func viewWillAppear(_ animated: Bool) {

  }
  override func viewWillDisappear(_ animated: Bool) {
   //Auth.auth().removeStateDidChangeListener(handle as AuthStateDidChangeListenerHandle)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    if Auth.auth().currentUser?.uid == nil {
      goToUploadBtn.isEnabled = false
      return
    } else {
      
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func sentForm(_ sender: UIButton) {
    createAccount()
  }
  
  func createAccount() {
    
    if enterUserNameTextFd.text! == "" {
      let alert = UIAlertController(title: "Ouch!", message: "You forgot to enter your username", preferredStyle: .alert)
      let alertMsg = UIAlertAction(title: "Alright", style: .cancel, handler: nil)
      alert.addAction(alertMsg)
      self.present(alert, animated: true, completion: nil)
    }
    if enterEmailTextFd.text! == "" {
      let alert = UIAlertController(title: "Oh no", message: "You forgot to enter your email", preferredStyle: .alert)
      let alertMsg = UIAlertAction(title: "Alright", style: .cancel, handler: nil)
      alert.addAction(alertMsg)
      self.present(alert, animated: true, completion: nil)
    } else if enterPsdTextFd.text! == "" {
      enterPsdTextFd.isFocused
      enterPsdTextFd.placeholder = "Ouch, you forgot to enter your password"
      
    } else if enterPsdTextFd.text! != confirmPsdTextFd.text! {
      let alert = UIAlertController(title: "Oh no", message: "Your password doesnt match", preferredStyle: .alert)
      let alertMsg = UIAlertAction(title: "Whattt", style: .cancel, handler: nil)
      alert.addAction(alertMsg)
      self.present(alert, animated: true, completion: nil)
    } else {
      
//////// once we r done with error checking, lets start create user
      let name = enterUserNameTextFd.text!
      let email = enterEmailTextFd.text!
      
      Auth.auth().createUser(withEmail: enterEmailTextFd.text!, password: enterPsdTextFd.text!) { (user, error) in
        if error != nil {
          print(error)
          return
        }
        guard let uid = user?.uid else { return }
        let userdefaults = UserDefaults.standard
        let ref = Database.database().reference(fromURL: "https://uploadphoto-7af69.firebaseio.com/")
        // this will add child user under the hierachy of "user" by auto generated uid
        let userRef = ref.child("user").child(uid)
        let values = ["name": name, "email": email]
        userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
              print(err)
              return
            }
            print("Successfully saved user into Firebase DB")
         
          // save current user name into userdefaults
          userdefaults.set(name, forKey: "currentDisplayName")
            let alert = UIAlertController(title: "Rock", message: "Successed! Your account has been created", preferredStyle: .alert)
            let alertMsg = UIAlertAction(title: "Perfect", style: .cancel, handler: nil)
            alert.addAction(alertMsg)
            self.present(alert, animated: true, completion: nil)
          self.goToUploadBtn.isEnabled = true
        })
      }
    }
  }
  
  @IBAction func logIn(_ sender: UIButton) {
    //self.dismiss(animated: true, completion: nil)
    self.performSegue(withIdentifier: "goToLogIn", sender: self)
  }
  
}
