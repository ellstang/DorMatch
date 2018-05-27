//
//  LogInViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 05/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var emailTextFd: UITextField!
  @IBOutlet weak var psdTextFd: UITextField!
  @IBOutlet weak var logInBtn: UIButton!
  //var rentCaseVC = RentCasesViewController()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func checkIfLoggedIn() {
    if (Auth.auth().currentUser?.isEmailVerified)! {
      self.navigationController?.popToRootViewController(animated: true)

    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  func prepare(for segue: UIStoryboardSegue, sender: Any?) -> RentCasesViewController? {
     let destination = segue.destination as! RentCasesViewController
    let rentCaseVC = destination
    return rentCaseVC
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
    
  @IBAction func logIn(_ sender: UIButton) {
    let databaseRef = Database.database().reference(fromURL: "https://uploadphoto-7af69.firebaseio.com/")
    
    Auth.auth().signIn(withEmail: emailTextFd.text!, password: psdTextFd.text!) { (user, error) in
      if error != nil {
        print(error)
        return
      } else {
        let alert = UIAlertController(title: "Successfully logged in!", message: "You are now logged in", preferredStyle: .alert)
        let alertMsg = UIAlertAction(title: "Perfect", style: .cancel, handler: nil)
        alert.addAction(alertMsg)
        self.present(alert, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
//        self.present(alert, animated: true, completion: {

      }
    }
  }
}
