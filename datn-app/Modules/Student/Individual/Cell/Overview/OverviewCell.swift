//
//  OverviewCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/22/22.
//

import UIKit

class OverviewCell: UITableViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var vKyhoc               : UIView!
    @IBOutlet weak var vTinchi              : UIView!
    @IBOutlet weak var vGPA                 : UIView!
    
    /// Kỳ học
    @IBOutlet weak var lblKyhocTitle        : UILabel!
    @IBOutlet weak var lblKyhoc             : UILabel!
    
    /// Tinchi
    @IBOutlet weak var lblTinchiTitle       : UILabel!
    @IBOutlet weak var lblTinchi            : UILabel!
    
    ///  GPA
    @IBOutlet weak var lblGPATitle          : UILabel!
    @IBOutlet weak var lblGPA               : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialzedContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initialzedContent() {
        self.vContentView.backgroundColor   = Constant.Color.app_background
        self.lblGPA.textColor               = Constant.Color.dark_blue
        self.lblGPATitle.textColor          = Constant.Color.dark_blue
        self.lblTinchi.textColor            = Constant.Color.dark_blue
        self.lblTinchiTitle.textColor       = Constant.Color.dark_blue
        self.lblKyhoc.textColor             = Constant.Color.dark_blue
        self.lblKyhocTitle.textColor        = Constant.Color.dark_blue
        
        self.lblTinchiTitle.font            = UIFont.getOpenSansSemiBoldFontSmall()
        self.lblGPATitle.font               = UIFont.getOpenSansSemiBoldFontSmall()
        self.lblKyhocTitle.font             = UIFont.getOpenSansSemiBoldFontSmall()
        
        self.lblTinchi.font                 = UIFont.getOpenSansBoldFont(size: 16)
        self.lblGPA.font                    = UIFont.getOpenSansBoldFont(size: 16)
        self.lblKyhoc.font                  = UIFont.getOpenSansBoldFont(size: 16)
    }
    
    func updateUI() {
        self.vKyhoc.layer.cornerRadius      = CGFloat(Constant.Values.commonRadius)
        self.vTinchi.layer.cornerRadius     = CGFloat(Constant.Values.commonRadius)
        self.vGPA.layer.cornerRadius        = CGFloat(Constant.Values.commonRadius)
        
        self.vKyhoc.clipsToBounds           = true
        self.vTinchi.clipsToBounds          = true
        self.vGPA.clipsToBounds             = true
    }
}
