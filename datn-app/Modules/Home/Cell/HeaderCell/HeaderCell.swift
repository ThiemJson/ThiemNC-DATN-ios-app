//
//  HeaderCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var vBottomHeader        : UIView!
    @IBOutlet weak var vDetail              : UIView!
    @IBOutlet weak var lblUsername          : UILabel!
    @IBOutlet weak var lblUsercode          : UILabel!
    @IBOutlet weak var lblClass             : UILabel!
    @IBOutlet weak var vAvatar              : UIView!
    @IBOutlet weak var imgAvatar            : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.vBottomHeader.backgroundColor  = Constant.Color.app_background
        
        self.vDetail.clipsToBounds          = true
        self.vDetail.backgroundColor        = .white
        
        self.lblUsercode.textColor          = Constant.Color.dark_blue
        self.lblUsername.textColor          = Constant.Color.dark_blue
        self.lblClass.textColor             = Constant.Color.dark_blue
        
        self.lblUsername.font               = UIFont.getOpenSansBoldFont(size: 19)
        self.lblUsercode.font               = UIFont.getOpenSansSemiBoldFontSmall()
        self.lblClass.font                  = UIFont.getOpenSansSemiBoldFontSmall()
        
        self.vDetail.setShadowRadiusView()
        self.vDetail.layer.cornerRadius     = CGFloat(Constant.Values.commonRadius)
    }
    
    func updateUI() {
        self.imgAvatar.layer.borderWidth      = 2
        self.imgAvatar.layer.borderColor      = Constant.Color.hex_green_19C285.cgColor
        self.imgAvatar.layer.cornerRadius     = CGFloat(self.vAvatar.frame.height / 2)
        self.imgAvatar.clipsToBounds          = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
