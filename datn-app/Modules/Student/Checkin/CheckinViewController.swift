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
    
    @IBOutlet weak var lblLocationHelper    : UILabel!
    @IBOutlet weak var lblDistance          : UILabel!
    
    var listInputLocation                   = [CLLocation(latitude: 21.046728, longitude: 105.786815), CLLocation(latitude: 21.046957759870452, longitude: 105.78854524881581), CLLocation(latitude: 21.046710, longitude: 105.788233)]
    var inputCLLocation                     = CLLocation(latitude: 21.046728, longitude: 105.786815)
    let disposeBag                          = DisposeBag()
    
    deinit {
        print("===> CheckinViewController init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializedContent()
        CoreLocationService.shared.requestAlwaysAuth()
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
        self.lblDistance.text               = ""
        
        self.lblClassName.textColor         = Constant.Color.dark_blue
        self.lblRoomTitle.textColor         = Constant.Color.gray_text_placeholder_search_bar
        self.lblStartTimeTitle.textColor    = Constant.Color.gray_text_placeholder_search_bar
        self.lblLocationTitle.textColor     = Constant.Color.gray_text_placeholder_search_bar
        self.lblSpeedTitle.textColor        = Constant.Color.gray_text_placeholder_search_bar
        self.lblTimeTitle.textColor         = Constant.Color.gray_text_placeholder_search_bar
        self.lblLectureTitle.textColor      = Constant.Color.gray_text_placeholder_search_bar
        self.lblLocationHelper.textColor    = Constant.Color.gray_text_placeholder_search_bar
        self.lblDistance.textColor          = Constant.Color.hex_green_19C285
        self.lblLocation.textColor          = Constant.Color.gray_light
        self.lblSpeed.textColor             = Constant.Color.gray_light
        self.lblTime.textColor              = Constant.Color.gray_light
        
        self.lblLectureTitle.font           = UIFont.getOpenSansBoldFont(size: 15)
        self.lblDistance.font               = UIFont.getOpenSansBoldFont(size: 23)
        self.lblLocationHelper.font         = UIFont.getOpenSansBoldFont(size: 14)
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
        self.vAnimationView.animationSpeed     = 1.0
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
        self.lblSpeed.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.inputCLLocation = self.listInputLocation[0]
        }).disposed(by: self.disposeBag)
        
        self.lblTime.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.inputCLLocation = self.listInputLocation[1]
        }).disposed(by: self.disposeBag)
        
        self.lblLocation.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.inputCLLocation = self.listInputLocation[2]
        }).disposed(by: self.disposeBag)
        
        self.vAnimationView.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            
            /// `Dừng searching`
            if self.vAnimationView.isAnimationPlaying {
                CoreLocationService.shared.stopScanningLocation()
                self.vAnimationView.stop()
                DispatchQueue.main.async {
                    AppMessagesManager.shared.showMessage(messageType: .success, message: "Dừng truy cập thông tin vị trí")
                }
                self.lblLocationHelper.text = "Chạm để truy cập thông tin vị trí"
                return
            }
            
            /// `Bắt đầu search`
            CoreLocationService.shared.startScanningLocation()
            self.lblLocationHelper.text = "Chạm để dừng truy cập thông tin vị trí"
            self.vAnimationView.play()
            DispatchQueue.main.async {
                AppMessagesManager.shared.showMessage(messageType: .success, message: "Bắt đầu truy cập thông tin vị trí")
            }
        }).disposed(by: self.disposeBag)
        
        CoreLocationService.shared.rxCLLocation.asDriver().drive(onNext: { [weak self] (location) in
            guard let `self` = self else { return }
            guard let location = location else {
                self.lblLocation.text   = "( ... , ...)"
                self.lblDistance.text   = ""
                return
            }
            let latitude    = location.coordinate.latitude
            let longitude    = location.coordinate.longitude
            print(" CORE-Location location: \(location)")
            print(" CORE-Location latitude: \(latitude) | longitude \(longitude)")
            
            if CLLocationCoordinate2DIsValid(location.coordinate) {
                self.lblLocation.text   = "( \(round(latitude * 100000000) / 100000000.0) , \(round(longitude * 100000000) / 100000000.0) )"
                
                let distance            = self.inputCLLocation.distance(from: location)
                let distanceRounded     = round(distance * 100) / 100.0
                self.lblDistance.text   = "\( (distanceRounded > 100) ? ">100m" : "\(distanceRounded)m" )"
                
                self.lblLocation.textColor      = Constant.Color.hex_245C83
                self.lblSpeed.textColor         = Constant.Color.hex_245C83
                self.lblTime.textColor          = Constant.Color.hex_245C83
                
                /// `Đổi màu chữ tương đương khoảng cách`
                if distanceRounded > 100 {
                    self.lblDistance.textColor  = Constant.Color.hex_red_F67280
                } else if distanceRounded > 20 {
                    self.lblDistance.textColor  = Constant.Color.hex_orange_F3AB1D
                } else {
                    self.lblDistance.textColor  = Constant.Color.hex_green_19C285
                }
                
            } else {
                self.lblLocation.text   = "( ... , ...)"
                self.lblDistance.text   = ""
            }
            
            self.lblSpeed.text          = "\(location.speed) mps"
            self.lblTime.text           = "\(location.timestamp.description(with: .current))"
            
        }).disposed(by: self.disposeBag)
    }
}
