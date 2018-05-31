
//
//  RentHouseCell.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 07/04/2018.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit

class RentHouseCell: UITableViewCell {

  @IBOutlet weak var houseImage: UIImageView!
  @IBOutlet weak var locationMainTitle: UILabel!
  @IBOutlet weak var posterDescriptionSubTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    houseImage.clipsToBounds = true
    houseImage.contentMode = .scaleAspectFit
    locationMainTitle.lineBreakMode = .byTruncatingHead
    posterDescriptionSubTitle.lineBreakMode = .byTruncatingHead
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
