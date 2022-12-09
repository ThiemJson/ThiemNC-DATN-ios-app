//
//  HotNewsCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit
import SDWebImage

class HotNewsCell: UITableViewCell {
    
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var clvContent           : UICollectionView!
    var timer                               : Timer?
    
    let dataInput = [["Chào mừng ngày nhà giáo Việt Nam 20/11 Khoa Công nghệ thông tin",
                      "https://cse.tlu.edu.vn/tin-thong-bao/chao-mung-ngay-nha-giao-viet-nam-20-11-khoa-cong-444",
                      "https://cse.tlu.edu.vn/Portals/0/nha-giao-vn.jpg"],
                     
                     ["SAMSUNG - SVMC]Học bổng STP và Tuyển dụng nhân viên khối kỹ thuật (không lập trình)",
                      "https://cse.tlu.edu.vn/tin-thong-bao/samsung--svmc-hoc-bong-stp-va-tuyen-dung-nhan-443",
                      "https://cse.tlu.edu.vn/Portals/0/hinh-anh-thong-bao-tuyenthumb.jpg"],
                     
                     ["Thông tin tuyển dụng Công ty Nashtech ",
                      "https://cse.tlu.edu.vn/tin-thong-bao/thong-tin-tuyen-dung-cong-ty-nashtech-420",
                      "https://cse.tlu.edu.vn/Portals/0/anh-natechthumb.jpg"],
                     
                     ["Triển khai đánh giá kết quả rèn luyện của sinh viên khóa 62 học kỳ 1 năm học 2020-2021",
                      "https://cse.tlu.edu.vn/thong-bao-sinh-vien/trien-khai-danh-gia-ket-qua-ren-luyen-cua-sinh-337",
                      "https://cse.tlu.edu.vn/Portals/0/thong%20bao.jpg"]
    ]
    
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
        
        self.startTimer()
    }
    
    
    private func scrollToNextCell(){
        let cellSize        = CGSize(width: self.clvContent.bounds.width * 0.49, height: self.clvContent.bounds.height)
        DispatchQueue.main.async {
            if self.clvContent.contentOffset.x >= (self.clvContent.contentSize.width - self.clvContent.frame.width) {
                self.clvContent.contentOffset.x = 0
            } else {
                self.clvContent.contentOffset.x  += cellSize.width
            }
        }
    }
    
    private func startTimer() {
        //        self.timer?.invalidate()
        //        self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { [weak self] _ in
        //            guard let `self` = self else { return }
        //            self.scrollToNextCell()
        //        })
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
        if indexPath.item < self.dataInput.count {
            let notiData            = self.dataInput[indexPath.item]
            DispatchQueue.main.async {
                cell.lblDescription.text    = notiData[0]
                cell.imgContent.sd_setImage(with: URL(string: notiData[2]),
                                            placeholderImage: UIImage(named: "notification_demo"),
                                            options: .refreshCached)
                
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clvContent.bounds.width * 0.49, height: self.clvContent.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.dataInput.count {
            let urlString = self.dataInput[indexPath.item][1]
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
