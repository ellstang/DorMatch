//  RentCasesViewCOntroller.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 05/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class RentCasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetSelectedCellInfoProtocol {
  
  let databaseRef: DatabaseReference = Database.database().reference(fromURL: "https://uploadphoto-7af69.firebaseio.com")
  var singleHouseViewController = SingleHouseViewController()
  
  @IBOutlet weak var logOutBtn: UIButton!
  @IBOutlet weak var rentCasesTableView: UITableView!
  @IBOutlet weak var postBtn: UIBarButtonItem!
  
  @IBAction func Post(_ sender: UIBarButtonItem) {
    self.performSegue(withIdentifier: "goToUploadImageVC", sender: nil)
  }
  
  @IBOutlet weak var signUpBtn: UIButton!
  @IBAction func signUp(_ sender: UIButton) {
    //self.performSegue(withIdentifier: "goCreateAccountVC", sender: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rentCasesTableView.delegate = self
    rentCasesTableView.dataSource = self
    
    rentCasesTableView.rowHeight = UITableViewAutomaticDimension
    
    //register RentHouseCell
    let nib = UINib(nibName: "RentHouseCell", bundle: nil)
    rentCasesTableView.register(nib, forCellReuseIdentifier: "Cell")
    
    checkIfLoggedIn()
    //fetchExistingUser()
    if displayPost.count == 0 {
      fetchAllExistingPostsFromDB()
    }
    // for GetSelectedCellInfoProtocol:
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    singleHouseViewController = mainStoryboard.instantiateViewController(withIdentifier: "SingelHouseVC") as! SingleHouseViewController
    singleHouseViewController.delegate = self
    //print(displayPost.count)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkIfLoggedIn()
    print(displayPost.count)
  }
  
  @IBAction func logOut(_ sender: UIButton) {
    signOut()
  }
  
  
  func checkIfLoggedIn() {
    if Auth.auth().currentUser?.uid == nil {
      signUpBtn.isHidden = false
      logOutBtn.isHidden = true
      postBtn.isEnabled = false
      presentAlertController(title: "Please Log in", msg: "Log in to post", actTitle: "ok")
    } else {
      let uid = Auth.auth().currentUser?.uid
      Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
        if let dictionary = snapshot.value as? [String: AnyObject] {
          self.navigationItem.title = dictionary["name"] as? String
        }
      }, withCancel: nil)
      signUpBtn.isHidden = true
      logOutBtn.isHidden = false
      postBtn.isEnabled = true
    }
  }
  
  func signOut() {
    if ((Auth.auth().currentUser?.uid) != nil) {
      do {
        try Auth.auth().signOut()
        logOutBtn.isHidden = true
        postBtn.isEnabled = false
        self.navigationItem.title = ""
      } catch let logOutError {
        print(logOutError)
      }
    }
    checkIfLoggedIn()
  }
  
  // this method allows us to fetch all existing users in our DB
  func fetchExistingUser() {
    Database.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
      if let dictionary = snapshot.value as? [String: AnyObject] {
        let user = User()
        // by using this method, we must make sure the key of dictionary corresponding to our DB, otherwise our APP will crash
        user.name = dictionary["name"] as? NSString
        user.email = dictionary["email"] as? String
        user.setValuesForKeys(dictionary)
        allUsers.append(user)
        self.rentCasesTableView.reloadData()
      }
    }, withCancel: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayPost.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RentHouseCell
    let post = displayPost[indexPath.row]
    cell.locationMainTitle.text = post.postTitle
    cell.posterDescriptionSubTitle.text = post.posterDescription
    cell.houseImage.clipsToBounds = true
    cell.houseImage.contentMode = .scaleAspectFit
    
    // 分開處理圖片跟文字的下載：download img from Firebase Stroage for houseImage in the tableview cell
    if let mainImageURL = post.imageURL {
      let url = URL(string: post.imageURL!) // cuase we stored the url as String before
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
        if error != nil {
          print(error?.localizedDescription)
          return
        }
        // * must delcare any queue regarding as UI component in the main queue
        DispatchQueue.main.async {
          cell.houseImage.image = UIImage(data: data!)
        }
      }.resume()
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    return footerView
  }
  
  func fetchAllExistingPostsFromDB() {
    databaseRef.child("Posts").observe(.childAdded) { (snapshot) in
      let PostDict = snapshot.value as! Dictionary<String, AnyObject>
      let thisImageURL = PostDict["imageURL"]
      let thisPosterDescription = PostDict["posterDescription"]
      let thisPostTitle = PostDict["postTitle"]
      let thisPostImageLongDescription = PostDict["imageLongDescription"]
      //create instance of class "Post_ForTableView" to store this snapshot and for append it to our displayPost array later
      let downloadedPost = Post_ForTableView()
      downloadedPost.imageURL = thisImageURL as! String
      downloadedPost.postTitle = thisPostTitle as! String
      downloadedPost.posterDescription = thisPosterDescription as! String
      downloadedPost.imageLongDescription = thisPostImageLongDescription as! String

      displayPost.append(downloadedPost)
      self.rentCasesTableView.reloadData()
    }
//    databaseRef.child("Posts").queryLimited(toLast: 10).observe(.childAdded, with: { (snapshot) in
//      print(snapshot.value)
//      print(snapshot.children)
//      print(snapshot.key)
//      let PostDict = snapshot.value as! Dictionary<String, AnyObject>
//      let thisImageURL = PostDict["imageURL"]
//      let thisPosterDescription = PostDict["posterDescription"]
//      let thisPostTitle = PostDict["postTitle"]
//      let thisPostImageLongDescription = PostDict["imageLongDescription"]
//      let downloadedPost = Post_ForTableView()
//      downloadedPost.imageURL = thisImageURL as! String
//      downloadedPost.postTitle = thisPostTitle as! String
//      downloadedPost.posterDescription = thisPosterDescription as! String
//      downloadedPost.imageLongDescription = thisPostImageLongDescription as! String
//      displayPost.append(downloadedPost)
//      self.rentCasesTableView.reloadData()
//    }, withCancel: nil)
//    databaseRef.child("Posts").queryLimited(toLast: 10).keepSynced(true)
  }
  
  func fetchAllExistingPostsFromDBWhenViewWillAppear() {
    databaseRef.child("Posts").observe(.childAdded) { (snapshot) in
      let PostDict = snapshot.value as! Dictionary<String, AnyObject>
      //print(PostDict)
      let thisImageURL = PostDict["imageURL"]
      let thisPosterDescription = PostDict["posterDescription"]
      let thisPostTitle = PostDict["postTitle"]
      
      //create instance of class "Post_ForTableView" to store this snapshot and for append it to our displayPost array later
      let downloadedPost = Post_ForTableView()
      downloadedPost.imageURL = thisImageURL as! String
      downloadedPost.postTitle = thisPostTitle as! String
      downloadedPost.posterDescription = thisPosterDescription as! String
      
      self.rentCasesTableView.reloadData()
    }
  }
  
  // MARK: - tableView delegate metohds
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedCellHouseInfoData.imageURL = displayPost[indexPath.row].imageURL
    selectedCellHouseInfoData.posterDescription = displayPost[indexPath.row].posterDescription
    selectedCellHouseInfoData.postTitle = displayPost[indexPath.row].postTitle
    selectedCellHouseInfoData.imageLongDescription = displayPost[indexPath.row].imageLongDescription
    
    //performSegue(withIdentifier: "BackToRentCasesVC", sender: nil)
    //now we got the info for that house, let go to that singleHouseViewController
    present(singleHouseViewController, animated: true, completion: nil)
  }
  
  // protocol GetSelectedCellInfoProtocol declared here:
  func getCellInfo() -> Post_Original {
    let returnPost = selectedCellHouseInfoData
    return returnPost
  }
  
  // MARK: - UIAlertCOntroller metohd
  func presentAlertController(title: String?, msg: String?, actTitle: String?) {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
    let alertAct = UIAlertAction(title: actTitle, style: .default, handler: nil)
    alert.addAction(alertAct)
    
    self.present(alert, animated: true, completion: nil)
  }
}



