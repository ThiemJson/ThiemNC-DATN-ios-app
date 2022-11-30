//
//  ScheduleTableCell.swift
//  datn-app
//
//  Created by ThiemJason on 30/11/2022.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import UIKit

class ScheduleTableCell: UITableViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var vTimeAndAddress      : UIView!
    
    @IBOutlet weak var vTime                : UIView!
    @IBOutlet weak var vAddress             : UIView!
    
    @IBOutlet weak var lblTIme              : UILabel!
    @IBOutlet weak var lblLocation          : UILabel!
    
    @IBOutlet weak var imgRight             : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.lblTitle.textColor         = Constant.Color.dark_blue
        self.lblTIme.textColor          = Constant.Color.dark_blue
        self.lblLocation.textColor      = Constant.Color.dark_blue
        
        self.lblTitle.font      = UIFont.getOpenSansBoldFont(size: 12)
        self.lblTIme.font       = UIFont.getOpenSansSemiBoldFontSmall()
        self.lblLocation.font   = UIFont.getOpenSansSemiBoldFontSmall()
        
        self.lblTitle.text      = "Môn học: Công nghệ Web"
        self.lblTIme.text       = "14:50"
        self.lblLocation.text   = "Phòng 302 - A2"
        
        self.imgRight.tintColor = Constant.Color.gray_light
        self.selectionStyle     = .none
    }
}
