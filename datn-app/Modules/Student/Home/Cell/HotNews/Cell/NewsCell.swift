//
//  NewsCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/21/22.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var imgContent           : UIImageView!
    @IBOutlet weak var lblDescription       : UILabel!
    @IBOutlet weak var stvContent           : UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.lblDescription.textColor       = Constant.Color.dark_blue
        self.lblDescription.font            = UIFont.getOpenSansRegularFontSmall()
        
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.vContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.vContentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: self.vContentView.bottomAnchor),
            self.leftAnchor.constraint(equalTo: self.vContentView.leftAnchor),
            self.rightAnchor.constraint(equalTo: self.vContentView.rightAnchor),
        ])
    }
    
    func updateUI() {
        self.imgContent.layer.cornerRadius  = CGFloat(Constant.Values.commonRadius)
        self.imgContent.clipsToBounds       = true
    }
}
