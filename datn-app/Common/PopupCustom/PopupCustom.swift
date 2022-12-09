//
//  PopupCustom.swift
//  datn-app
//
//  Created by ThiemJason on 11/17/22.
//

import UIKit
import RxSwift
import Lottie
import RxCocoa
import SVProgressHUD

enum PopupCustomType {
    case Loading
    case Error
    case Success
    case Attention
    case Noti
}

class PopupCustom: UIViewController {
    @IBOutlet weak var vContent         : UIView!
    @IBOutlet weak var vBlackBackground : UIView!
    @IBOutlet weak var stvContent       : UIStackView!
    @IBOutlet weak var stvTop           : UIStackView!
    @IBOutlet weak var stvBot           : UIStackView!
    @IBOutlet weak var vLottie          : AnimationView!
    
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblContent       : UILabel!
    
    let rxPopupCustomMode               = BehaviorRelay<PopupCustomType>(value: .Loading)
    let disposeBag                      = DisposeBag()
    @IBOutlet weak var vLeftBtn         : UIView!
    @IBOutlet weak var vRightBtn        : UIView!
    @IBOutlet weak var btnLeft          : UIButton!
    @IBOutlet weak var btnRight         : UIButton!
    var isAutoDissmis: Int?             = nil
    var isDismissable: Bool?            = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.setupView()
        self.handlerAction()
        self.setupBinding()
        self.vLottie.contentMode        = .scaleAspectFill
        self.vLottie.loopMode           = .loop
        self.vLottie.animationSpeed     = 1.0
        self.vLottie.play()
    }
    
    private func setupView() {
        self.vContent.backgroundColor       = .white
        self.vContent.layer.shadowColor     = Constant.Color.black_opa_25.cgColor
        self.vContent.layer.shadowOpacity   = 1
        self.vContent.layer.shadowOffset    = CGSize(width: 0, height: 2)
        self.vContent.layer.shadowRadius    = 0.0
        self.vContent.layer.masksToBounds   = false
        self.vContent.layer.cornerRadius    = 20
        self.lblTitle.textColor             = Constant.Color.dark_blue
        self.lblContent.textColor           = Constant.Color.dark_blue
        self.lblTitle.font                  = UIFont.getOpenSansSemiBoldFontTitle()
        self.lblContent.font                = UIFont.getOpenSansRegularFontDefault()
        
        self.vLeftBtn.layer.cornerRadius    = 10
        self.vLeftBtn.layer.borderWidth     = 2
        self.vLeftBtn.layer.borderColor     = Constant.Color.hex_2D74E7.cgColor
        self.vRightBtn.layer.cornerRadius   = 10
        self.vLeftBtn.clipsToBounds         = true
        self.vRightBtn.clipsToBounds        = true
        self.vLeftBtn.layer.borderColor = Constant.Color.hex_2D74E7.cgColor
        
        if let isAutoDissmis = self.isAutoDissmis {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(isAutoDissmis)) {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
        self.vBlackBackground.rx.tap().asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            if self.isDismissable ?? false {
                self.dismiss(animated: true)
            }
        }).disposed(by: self.disposeBag)
        
        self.rxPopupCustomMode.asDriver().drive(onNext: { [weak self] (mode) in
            guard let `self` = self else { return }
            switch mode {
            case .Success:
                break
            case .Loading:
                break
            case .Attention:
                break
            case .Noti:
                break
            case .Error:
                break
            default:
                break
            }
        }).disposed(by: self.disposeBag)
    }
}
