//
//  LearningCell.swift
//  datn-app
//
//  Created by vnpt on 29/11/2022.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//
import UIKit

class LearningCell: UITableViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var vContentWrapper      : UIView!
    @IBOutlet weak var stvContent           : UIStackView!
    
    @IBOutlet weak var vTKB                 : NavRowCustom!
    @IBOutlet weak var vKetquahoctap        : NavRowCustom!
    @IBOutlet weak var vLophanhchinh        : NavRowCustom!
    @IBOutlet weak var vDangkyhoc           : NavRowCustom!
    @IBOutlet weak var vTientrinhhoc        : NavRowCustom!
    @IBOutlet weak var vTracnghiem          : NavRowCustom!
    
    @IBOutlet weak var constRowHeight       : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.vContentView.backgroundColor       = Constant.Color.app_background
        
        self.stvContent.backgroundColor         = Constant.Color.app_background
        
        self.vTKB.lblContent.text               = "Thời khoá biểu"
        self.vTKB.imgLeftIcon.image             = UIImage(named: "calendar")
        
        self.vKetquahoctap.lblContent.text      = "Kết quả học tập"
        self.vKetquahoctap.imgLeftIcon.image    = UIImage(named: "pie-chart")
        
        self.vLophanhchinh.lblContent.text      = "Lớp tín chỉ"
        self.vLophanhchinh.imgLeftIcon.image    = UIImage(named: "profle")
        
        self.vDangkyhoc.lblContent.text         = "Đăng ký học phần"
        self.vDangkyhoc.imgLeftIcon.image       = UIImage(named: "news")
        
        self.vTientrinhhoc.lblContent.text      = "Tiến trình học tập"
        self.vTientrinhhoc.imgLeftIcon.image    = UIImage(named: "trophy")
        
        self.vTracnghiem.lblContent.text        = "Trắc nghiệm"
        self.vTracnghiem.imgLeftIcon.image      = UIImage(named: "compose")
    }
    
    func updateUI() {
        self.vContentWrapper.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        self.vContentWrapper.clipsToBounds      = true
    }
}
