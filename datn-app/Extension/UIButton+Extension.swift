//
//  UIButton+Extension.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 7/3/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import UIKit
extension UIButton {
    func addCornerAndColor(color: UIColor, cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = color
    }
    
    func addImageInsets(top:CGFloat, left:CGFloat, bottom:CGFloat,right:CGFloat){
        self.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func turnOnButton() {
        self.isSelected = true
        self.setImage(UIImage(named: "Icon_log_in"), for: .normal)
        self.backgroundColor = Constant.Color.btn_on_color
    }
    
    func turnOffButton() {
        self.isSelected = false
        self.setImage(UIImage(named: "Icon_log_out"), for: .normal)
        self.backgroundColor = Constant.Color.btn_off_color
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func setBorderButton(_ tittle: String = "", _ color: UIColor = Constant.Color.hex_2D74E7) {
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = color
        if tittle != "" {
            self.setTitle(tittle, for: .normal)
        }
    }
}
