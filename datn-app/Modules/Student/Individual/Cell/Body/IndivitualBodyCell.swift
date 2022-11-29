//
//  IndivitualBodyCell.swift
//  datn-app
//
//  Created by ThiemJason on 21/11/2022.
//

import UIKit

class IndivitualBodyCell: UITableViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var vContentWrapper      : UIView!
    @IBOutlet weak var stvContent           : UIStackView!
    
    @IBOutlet weak var vUserInfo            : NavRowCustom!
    @IBOutlet weak var vEventSchedule       : NavRowCustom!
    @IBOutlet weak var vResponse            : NavRowCustom!
    @IBOutlet weak var vFaceID              : NavRowCustom!
    @IBOutlet weak var vSocialNetword       : NavRowCustom!
    @IBOutlet weak var vLogout              : NavRowCustom!
    @IBOutlet weak var vLogoutWrapepr       : UIView!
    
    @IBOutlet weak var constRowHeight       : NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.vContentView.backgroundColor   = Constant.Color.app_background
        
        // User info
        self.vUserInfo.lblContent.text          = "Thông tin cá nhân"
        self.vUserInfo.imgLeftIcon.image        = UIImage(named: "profle")
        
        // Event schedule
        self.vEventSchedule.lblContent.text     = "Lịch thi, sự kiện sắp tới"
        self.vEventSchedule.imgLeftIcon.image   = UIImage(named: "calendar")
        
        // Response
        self.vResponse.lblContent.text          = "Đang chờ phản hồi"
        self.vResponse.imgLeftIcon.image        = UIImage(named: "rocket")
        
        // FaceID
        self.vFaceID.lblContent.text            = "Cài đặt vân tay/ Face ID"
        self.vFaceID.imgLeftIcon.image          = UIImage(named: "locked")
        
        // Mạng xã hội
        self.vSocialNetword.lblContent.text     = "Mạng xã hội"
        self.vSocialNetword.imgLeftIcon.image   = UIImage(named: "heart")
        
        // Logout
        self.vLogout.lblContent.text            = "Đăng xuất"
        self.vLogout.imgLeftIcon.image          = UIImage(named: "power")
    }
    
    func updateUI() {
        // StackView Contene
        self.stvContent.backgroundColor         = Constant.Color.app_background
        self.vContentWrapper.setShadowBottom()
        self.vContentWrapper.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        self.vContentWrapper.clipsToBounds      = true
        
        self.vLogoutWrapepr.setShadowBottom()
        self.vLogoutWrapepr.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        self.vLogoutWrapepr.clipsToBounds      = true
    }
}
