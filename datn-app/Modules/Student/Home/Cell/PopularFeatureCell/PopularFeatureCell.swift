//
//  PopularFeatureCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit

class PopularFeatureCell: UITableViewCell {
    @IBOutlet weak var vContentView     : UIView!
    @IBOutlet weak var lblTItle         : UILabel!
    
    // F1
    @IBOutlet weak var vF1              : UIView!
    @IBOutlet weak var imgF1            : UIImageView!
    @IBOutlet weak var vIconInsideF1    : UIView!
    @IBOutlet weak var lblIconF1        : UILabel!
    
    // F2
    @IBOutlet weak var vF2              : UIView!
    @IBOutlet weak var imgF2            : UIImageView!
    @IBOutlet weak var vIconInsideF2    : UIView!
    @IBOutlet weak var lblIconF2        : UILabel!
    
    // F3
    @IBOutlet weak var vF3              : UIView!
    @IBOutlet weak var imgF3            : UIImageView!
    @IBOutlet weak var vIconInsideF3    : UIView!
    @IBOutlet weak var lblIconF3        : UILabel!
    
    // F4
    @IBOutlet weak var vF4              : UIView!
    @IBOutlet weak var imgF4            : UIImageView!
    @IBOutlet weak var vIconInsideF4    : UIView!
    @IBOutlet weak var lblIconF4        : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.vContentView.backgroundColor   = Constant.Color.app_background
        self.lblTItle.font                  = UIFont.getOpenSansBoldFont(size: 15)
        self.lblTItle.textColor             = Constant.Color.dark_blue
    }
    
    func updateUI() {
        self.setShadowView(uiViews: [self.vF1, self.vF2, self.vF4, self.vF3])
    }
    
    private func setShadowView( uiViews: [UIView] ) {
        uiViews.forEach { (uiView) in
            uiView.layer.cornerRadius   = CGFloat(Constant.Values.commonRadius)
            uiView.clipsToBounds        = true
        }
        
        self.lblIconF1.textColor        = Constant.Color.dark_blue
        self.lblIconF1.font             = UIFont.getOpenSansRegularFontSmall()

        self.lblIconF2.textColor        = Constant.Color.dark_blue
        self.lblIconF2.font             = UIFont.getOpenSansRegularFontSmall()
        
        self.lblIconF3.textColor        = Constant.Color.dark_blue
        self.lblIconF3.font             = UIFont.getOpenSansRegularFontSmall()
        
        self.lblIconF4.textColor        = Constant.Color.dark_blue
        self.lblIconF4.font             = UIFont.getOpenSansRegularFontSmall()
    }
}
