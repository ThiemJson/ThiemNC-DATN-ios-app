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
    
    let rxPopupCustomMode               = BehaviorRelay<PopupCustomType>(value: .Loading)
    let disposeBag                      = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.setupView()
        self.handlerAction()
        self.setupBinding()
    }
    
    private func setupView() {
        
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
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
