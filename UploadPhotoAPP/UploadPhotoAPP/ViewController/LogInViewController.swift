//  LogInViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 05/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

  @IBOutlet weak var emailTextFd: UITextField!
  @IBOutlet weak var psdTextFd: UITextField!
  @IBOutlet weak var logInBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

//  func checkIfLoggedIn() {
//    if (Auth.auth().currentUser?.isEmailVerified)! {
//      self.navigationController?.popToRootViewController(animated: true)
//    }
//  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - prepare for segue
  func prepare(for segue: UIStoryboardSegue, sender: Any?) -> RentCasesViewController? {
     let destination = segue.destination as! RentCasesViewController
    let rentCaseVC = destination
    return rentCaseVC
  }
  
    
  @IBAction func logIn(_ sender: UIButton) {
    let databaseRef = Database.database().reference(fromURL: "https://uploadphoto-7af69.firebaseio.com/")
    
    Auth.auth().signIn(withEmail: emailTextFd.text!, password: psdTextFd.text!) { (user, error) in
      if error != nil {
        let errMsg = error?.localizedDescription
        let errAlert = self.popAlert(title: "ohoh", msg: errMsg, msgAct: "please check your spelling")
        self.present(errAlert, animated: true, completion: nil)
        return
      } else {
        let alert = UIAlertController(title: "Successfully logged in!", message: "You are now logged in", preferredStyle: .alert)
        let alertMsg = UIAlertAction(title: "Perfect", style: .cancel, handler: { (Void) in
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let RentCasesVC = storyboard.instantiateViewController(withIdentifier: "RentCasesVC")
          self.present(RentCasesVC, animated: true, completion: nil)
        })
        alert.addAction(alertMsg)
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    psdTextFd.resignFirstResponder()
    emailTextFd.resignFirstResponder()
  }
  
  
  func popAlert(title: String?, msg: String?, msgAct: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let act = UIAlertAction(title: msgAct, style: .default, handler: nil)
    alert.addAction(act)
    return alert
  }
}
