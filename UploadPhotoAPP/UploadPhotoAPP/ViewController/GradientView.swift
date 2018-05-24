//  GradientView.swift
//  UploadPhotoAPP
//
//  Created by 唐嘉伶 on 2018/4/25.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit

@IBDesignable
class GradientView: UIView {
  @IBInspectable
  var topColor: UIColor = UIColor(red: 0.06, green: 0.13, blue: 0.27, alpha: 0.5) {
    didSet {
      self.setNeedsLayout()
    }
  }
  @IBInspectable
  var bottomColor: UIColor = UIColor(red: 0.12, green: 0.17, blue: 0.37, alpha: 0.5) {
    didSet {
      self.setNeedsLayout()
    }
  }
  override func layoutSubviews() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.white.cgColor, bottomColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.8)
    gradientLayer.frame = self.bounds
    self.layer.addSublayer(gradientLayer)
  }
}

@IBDesignable
class CustomButton: UIButton {
  
}
