//
//  IndivitualHeaderCell.swift
//  datn-app
//
//  Created by ThiemJason on 21/11/2022.
//

import UIKit

class IndivitualHeaderCell: UITableViewCell {
    @IBOutlet weak var vContentView     : UIView!
    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var imgEdit          : UIImageView!
    @IBOutlet weak var lblMSV           : UILabel!
    @IBOutlet weak var lblClass         : UILabel!
    @IBOutlet weak var imgAvt           : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.lblMSV.textColor           = Constant.Color.dark_blue
        self.lblClass.textColor         = Constant.Color.dark_blue
        self.lblName.textColor          = Constant.Color.dark_blue
        
        self.lblMSV.text                = "MSV: 1851061743"
        self.lblClass.text              = "Lớp: 60TH3"
        self.lblName.text               = "Nguyễn Cao Thiêm"
        
        self.lblName.font               = UIFont.getOpenSansBoldFont(size: 20)
        self.lblMSV.font                = UIFont.getOpenSansSemiBoldFontDefault()
        self.lblClass.font              = UIFont.getOpenSansSemiBoldFontDefault()
    }
    
    func updateUI() {
        //        self.imgAvt.layer.borderWidth   = 3
        //        self.imgAvt.layer.borderColor   = UIColor.white.cgColor
        //                self.imgAvt.layer.shadowColor   = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        //                self.imgAvt.layer.shadowOffset  = CGSize(width: 2, height: 5)
        //                self.imgAvt.layer.shadowRadius  = 3
        //                self.imgAvt.layer.shadowOpacity = 0.8
        //                self.imgAvt.layer.masksToBounds = false
        self.imgAvt.image               = self.imgAvt.image?.circleMaskWithShadow
    }
}
