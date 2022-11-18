//
//  DefaultHomeTableViewCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit

class DefaultHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor    = Constant.Color.app_background
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
