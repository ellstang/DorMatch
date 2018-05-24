//
//  fetchImageUrlProtocol.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 08/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import Foundation

protocol FetchImageUrlProtocol {
  func fetchImageUrl() -> String
}


protocol GetSelectedCellInfoProtocol {
  func getCellInfo() -> Post_Original
  
}
