//
//  HotNewsCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit

class HotNewsCell: UITableViewCell {
    
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var clvContent           : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    private func initializedContent() {
        self.vContentView.backgroundColor   = Constant.Color.app_background
        self.lblTitle.font                  = UIFont.getOpenSansBoldFont(size: 15)
        self.lblTitle.textColor             = Constant.Color.dark_blue
        self.lblTitle.text                  = "Tin nổi bật"
        
        // Collection view cell
        self.clvContent.register(UINib(nibName: "HotNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotNewsCollectionViewCell")
        self.clvContent.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        self.clvContent.delegate            = self
        self.clvContent.dataSource          = self
    }
}

extension HotNewsCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        cell.updateUI()
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clvContent.bounds.width * 0.49, height: self.clvContent.bounds.height)
    }
}
