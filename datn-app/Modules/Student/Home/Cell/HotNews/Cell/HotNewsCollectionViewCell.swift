//
//  HotNewsCollectionViewCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/21/22.
//

import UIKit

class HotNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var imgContent           : UIImageView!
    @IBOutlet weak var lblDescription       : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.vContentView.backgroundColor   = .red
        self.lblDescription.textColor       = Constant.Color.dark_blue
        self.lblDescription.font            = UIFont.getOpenSansSemiBoldFontDefault()
    }
    
    func updateUI() {
        self.imgContent.layer.cornerRadius  = CGFloat(Constant.Values.commonRadius)
        self.imgContent.clipsToBounds       = true
    }
}
