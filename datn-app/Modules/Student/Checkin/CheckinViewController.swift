//
//  CheckinViewController.swift
//  datn-app
//
//  Created by ThiemJason on 12/10/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Lottie
import CoreLocation

class CheckinViewController: UIViewController {
    @IBOutlet weak var lblClassName         : UILabel!
    @IBOutlet weak var vContent             : UIView!
    @IBOutlet weak var vAnimationView       : AnimationView!
    @IBOutlet weak var vLocationScanning    : UIView!
    @IBOutlet weak var scvContent           : UIScrollView!
    
    @IBOutlet weak var lblStartTime         : UILabel!
    @IBOutlet weak var lblStartTimeTitle    : UILabel!
    
    @IBOutlet weak var lblLectureTitle      : UILabel!
    @IBOutlet weak var lblLecture           : UILabel!
    
    @IBOutlet weak var lblRoomTitle         : UILabel!
    @IBOutlet weak var lblRoom              : UILabel!
    
    @IBOutlet weak var btnNormalCI          : UIButton!
    @IBOutlet weak var btnQRCI              : UIButton!
    
    @IBOutlet weak var lblLocationTitle     : UILabel!
    @IBOutlet weak var lblLocation          : UILabel!
    
    @IBOutlet weak var lblSpeedTitle        : UILabel!
    @IBOutlet weak var lblSpeed             : UILabel!
        
    @IBOutlet weak var lblTimeTitle         : UILabel!
    @IBOutlet weak var lblTime              : UILabel!
    
    var inputCLLocation                     = CLLocation(latitude: 21.046870, longitude: 05.787996)
    let disposeBag                          = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializedContent()
        CoreLocationService.shared.requestAlwaysAuth()
        CoreLocationService.shared.startScanningLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CoreLocationService.shared.stopScanningLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func initializedContent() {
        self.setupView()
        self.setupNavigation()
    }
    
    private func setupView() {
        self.handlerAction()
        self.setupBinding()
        
        self.scvContent.alwaysBounceVertical        = false
        self.scvContent.alwaysBounceHorizontal      = false
        self.scvContent.bounces                     = false
        self.view.backgroundColor                   = Constant.Color.app_background
        self.vContent.backgroundColor               = .white
        self.vContent.setShadowBotView()
        self.vLocationScanning.backgroundColor      = .white
        self.vLocationScanning.setShadowBotView()
        self.vContent.layer.cornerRadius            = CGFloat(Constant.Values.commonRadius)
        self.vLocationScanning.layer.cornerRadius   = CGFloat(Constant.Values.commonRadius)
        
        self.lblClassName.text              = "Công nghệ web"
        
        self.lblClassName.textColor         = Constant.Color.dark_blue
        self.lblRoomTitle.textColor         = Constant.Color.gray_text_placeholder_search_bar
        self.lblStartTimeTitle.textColor    = Constant.Color.gray_text_placeholder_search_bar
        self.lblLocationTitle.textColor     = Constant.Color.gray_text_placeholder_search_bar
        self.lblSpeedTitle.textColor        = Constant.Color.gray_text_placeholder_search_bar
        self.lblTimeTitle.textColor         = Constant.Color.gray_text_placeholder_search_bar
        self.lblLectureTitle.textColor      = Constant.Color.gray_text_placeholder_search_bar
        
        self.lblLectureTitle.font           = UIFont.getOpenSansBoldFont(size: 15)
        self.lblLecture.font                = UIFont.getOpenSansBoldFont(size: 15)
        self.lblTimeTitle.font              = UIFont.getOpenSansBoldFont(size: 15)
        self.lblTime.font                   = UIFont.getOpenSansBoldFont(size: 14)
        self.lblSpeedTitle.font             = UIFont.getOpenSansBoldFont(size: 15)
        self.lblSpeed.font                  = UIFont.getOpenSansBoldFont(size: 15)
        self.lblLocation.font               = UIFont.getOpenSansBoldFont(size: 15)
        self.lblLocationTitle.font          = UIFont.getOpenSansBoldFont(size: 15)
        self.lblRoomTitle.font              = UIFont.getOpenSansBoldFont(size: 15)
        self.lblStartTimeTitle.font         = UIFont.getOpenSansBoldFont(size: 15)
        self.lblStartTime.font              = UIFont.getOpenSansBoldFont(size: 15)
        self.lblRoom.font                   = UIFont.getOpenSansBoldFont(size: 15)
        
        /// `Title`
        self.lblClassName.font              = UIFont.getOpenSansBoldFont(size: 25)
        
        /// `Button`
        self.btnNormalCI.setTitle("Điểm danh", for: .normal)
        self.btnQRCI.setTitle("Quét QR", for: .normal)
        
        self.btnNormalCI.setTitleColor(.white, for: .normal)
        self.btnQRCI.setTitleColor(.white, for: .normal)
        
        self.btnQRCI.titleLabel?.font       = UIFont.getOpenSansBoldFont(size: 17)
        self.btnNormalCI.titleLabel?.font   = UIFont.getOpenSansBoldFont(size: 17)
        
        self.btnNormalCI.backgroundColor    = Constant.Color.dark_blue
        self.btnQRCI.backgroundColor        = Constant.Color.dark_blue
        
        self.btnQRCI.layer.cornerRadius     = CGFloat(Constant.Values.commonRadius)
        self.btnNormalCI.layer.cornerRadius = CGFloat(Constant.Values.commonRadius)
        
        self.btnQRCI.setImage(UIImage(systemName: "qrcode")!, for: .normal)
        self.btnQRCI.imageView?.contentMode = .scaleAspectFit
        self.btnQRCI.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        self.btnNormalCI.setImage(UIImage(systemName: "location.circle.fill")!, for: .normal)
        self.btnNormalCI.imageView?.contentMode = .scaleAspectFit
        self.btnNormalCI.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        
        self.vAnimationView.contentMode        = .scaleAspectFill
        self.vAnimationView.loopMode           = .loop
        self.vAnimationView.animationSpeed     = 0.5
        self.vAnimationView.play()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "icon_splash_background"), for: .top, barMetrics: .default)
        self.navigationController?.navigationBar.isTranslucent          = true
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.text          = "Thông tin điểm danh";
        label.font          = UIFont.getOpenSansSemiBoldFontTitle()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        let notification                        = UIImage(named: "logo_circle_png")
        let notificationImgView                 = UIImageView(image: notification)
        notificationImgView.frame               = CGRect(x:0.0,y:0.0, width:35,height:35)
        notificationImgView.contentMode         = .scaleAspectFit
        let imgRightItem                        = UIBarButtonItem(customView: notificationImgView)
        let widthConstraintRight                = notificationImgView.widthAnchor.constraint(equalToConstant: 35)
        let heightConstraintRight               = notificationImgView.heightAnchor.constraint(equalToConstant: 35)
        heightConstraintRight.isActive          = true
        widthConstraintRight.isActive           = true
        
        self.navigationItem.rightBarButtonItem  =  imgRightItem
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
        CoreLocationService.shared.rxCLLocation.asDriver().drive(onNext: { [weak self] (location) in
            guard let `self` = self else { return }
            guard let location = location else {
                self.lblLocation.text   = "( ... , ...)"
                return
            }
            let latitude    = location.coordinate.latitude
            let longitude    = location.coordinate.longitude
            print(" CORE-Location location: \(location)")
            print(" CORE-Location latitude: \(latitude) | longitude \(longitude)")
            
            if CLLocationCoordinate2DIsValid(location.coordinate) {
                self.lblLocation.text = "( \(round(latitude * 100000000) / 100000000.0) , \(round(longitude * 100000000) / 100000000.0) )"
            } else {
                self.lblLocation.text   = "( ... , ...)"
            }
            
            self.lblSpeed.text          = "\(location.speed) mps"
            self.lblTime.text           = "\(location.timestamp.description(with: .current))"
            
        }).disposed(by: self.disposeBag)
    }
}
