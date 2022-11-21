//
//  UrgenNotiCell.swift
//  datn-app
//
//  Created by STC VNPT on 11/21/22.
//

import UIKit

class UrgenNotiCell: UITableViewCell {
    @IBOutlet weak var imgContent       : UIImageView!
    @IBOutlet weak var vContentView     : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vContentView.backgroundColor   = Constant.Color.app_background
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI() {
        self.imgContent.layer.cornerRadius  = CGFloat(Double(Constant.Values.commonRadius) * 2)
        self.imgContent.clipsToBounds       = true
    }
}
