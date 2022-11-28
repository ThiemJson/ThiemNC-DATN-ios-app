//
//  FeatureBodyCell.swift
//  datn-app
//
//  Created by ThiemJason on 28/11/2022.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import UIKit

class FeatureBodyCell: UITableViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var vContentWrapper      : UIView!
    @IBOutlet weak var vBottomContent       : UIView!
    @IBOutlet weak var stvContent           : UIStackView!
    @IBOutlet weak var stvBottomContent     : UIStackView!
    
    @IBOutlet weak var vNews                : NavRowCustom!
    @IBOutlet weak var vGioithieu           : NavRowCustom!
    @IBOutlet weak var vVanbanHD            : NavRowCustom!
    @IBOutlet weak var vDichvumotcua        : NavRowCustom!
    @IBOutlet weak var vThongtincongno      : NavRowCustom!
    
    @IBOutlet weak var vPhanhoi             : NavRowCustom!
    @IBOutlet weak var vKhaosat             : NavRowCustom!
    @IBOutlet weak var vKhaibaosuckhoe      : NavRowCustom!
    @IBOutlet weak var vCSMap               : NavRowCustom!
    @IBOutlet weak var vDangkyTA            : NavRowCustom!
    
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
        self.stvBottomContent.backgroundColor   = Constant.Color.app_background
        
        self.vNews.lblContent.text              = "Tin tức"
        self.vNews.imgLeftIcon.image            = UIImage(named: "teacher")
        
        self.vGioithieu.lblContent.text         = "Giới thiệu về Khoa CNTT"
        self.vGioithieu.imgLeftIcon.image       = UIImage(named: "teacher")
        
        self.vVanbanHD.lblContent.text          = "Văn bản hướng dẫn"
        self.vVanbanHD.imgLeftIcon.image        = UIImage(named: "teacher")
        
        self.vDichvumotcua.lblContent.text      = "Dịch vụ một cửa"
        self.vDichvumotcua.imgLeftIcon.image    = UIImage(named: "teacher")
        
        self.vThongtincongno.lblContent.text    = "Thông tin công nợ"
        self.vThongtincongno.imgLeftIcon.image  = UIImage(named: "teacher")
        
        self.vPhanhoi.lblContent.text           = "Phản hồi"
        self.vPhanhoi.imgLeftIcon.image         = UIImage(named: "teacher")
        
        self.vKhaosat.lblContent.text           = "Khảo sát"
        self.vKhaosat.imgLeftIcon.image         = UIImage(named: "teacher")
        
        self.vKhaibaosuckhoe.lblContent.text    = "Khai báo sức khoẻ"
        self.vKhaibaosuckhoe.imgLeftIcon.image  = UIImage(named: "teacher")
        
        self.vCSMap.lblContent.text             = "CSE Map"
        self.vCSMap.imgLeftIcon.image           = UIImage(named: "teacher")
        
        self.vDangkyTA.lblContent.text          = "Đăng ký Tiếng anh"
        self.vDangkyTA.imgLeftIcon.image        = UIImage(named: "teacher")
    }
    
    func updateUI() {
        self.vContentWrapper.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        self.vContentWrapper.clipsToBounds      = true
        
        self.vBottomContent.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        self.vBottomContent.clipsToBounds      = true
    }
}
