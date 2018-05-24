//  SendMsgViewController.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 2018/4/26.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class SendMsgViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var sendMsgBtn: UIButton!
  @IBOutlet weak var chatRoomTableView: UITableView!
  @IBOutlet weak var messageTextFd: UITextField!
  
  
  let messageDBRef = Database.database().reference(withPath: "Messages")
  let currentUserRef = Database.database().reference(withPath: "user")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(Auth.auth().currentUser?.displayName)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func sendMsg(_ sender: Any) {
    guard messageTextFd.text != "" else {
      return
    }
    //get current user username:
//    let currentDisplayName = ""
//    currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
//      let currentUid = Auth.auth().currentUser?.uid
//
//    }
    let userdefualts = UserDefaults.standard
    let thisMsg = Message()
    thisMsg.msgContent = messageTextFd.text! as NSString
    thisMsg.sender?.name = Auth.auth().currentUser?.displayName as! NSString
    print(thisMsg.sender?.name = Auth.auth().currentUser?.displayName as! NSString )
    let currentUserName = userdefualts.object(forKey: "currentDisplayName")
    let msg = ["msgContent": thisMsg.msgContent, "sender": currentUserName]
    messageDBRef.childByAutoId().updateChildValues(msg)
  
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let myCell = tableView.dequeueReusableCell(withIdentifier: "SenderCell") as! MyMsgCell
//    let othersCell = tableView.dequeueReusableCell(withIdentifier: "othersCell") as! OthersMsgCell
    
    return myCell
  }
}
