//  PostModel.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 22/03/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.


import Foundation
import Firebase

struct Post_Original {
  var postTitle: String?  // MAIN TITLE: house type / location (near by...)
  var imageURL: String?
  var theAddress: String? // not for now
  var imageLongDescription: String? // long description
  
  var postUserName: String?
  var posterDescription: String?

  var post: [String: AnyObject]?
}

//use struct or class??
class Post_ForTableView: NSObject {
  var postTitle: String?
  var imageURL: String? //compressed
  var posterDescription: String?
  var imageLongDescription: String?
  
  var postUserUid: String?
  var postUserName: String?
}

var allPost = [Post_Original]() // for DB
var displayPost = [Post_ForTableView]() // for "rentcases table view"

var postsStorageArray: [String: AnyObject] = [String: AnyObject]()
var selectedCellHouseInfoData = Post_Original()


