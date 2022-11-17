//
//  TextFieldCustom.swift
//  datn-app
//
//  Created by ThiemJason on 11/17/22.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldCustom: UIView {
    @IBOutlet var mainView                  : UIView!
    @IBOutlet weak var vContentView         : UIView!
    @IBOutlet weak var tfTextField          : UITextField!
    @IBOutlet weak var btnShow              : UIButton!
    
    let rxIsShowContent                     = BehaviorRelay<Bool>(value: true)
    let disposeBag                          = DisposeBag()
    var isSecureTextField                   = false
    var contentPlaceHolder                  = " ..."
    var defaultValue : String?              = nil
    
    // MARK: Setting UI View
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializedView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializedView()
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed("TextFieldCustom", owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame                     = self.bounds
        self.mainView.autoresizingMask          = [.flexibleHeight, .flexibleWidth]
        self.updateUI()
        self.setupBinding()
    }
    
    func updateUI() {
        self.vContentView.setBorderView()
        self.vContentView.layer.cornerRadius    = 10
        self.btnShow.imageView?.contentMode     = .scaleAspectFit
        self.tfTextField.isSecureTextEntry      = self.isSecureTextField
        self.tfTextField.placeholder            = self.contentPlaceHolder
        self.tfTextField.textColor              = Constant.Color.dark_blue
        
        if let defaultValue = self.defaultValue {
            self.tfTextField.text               = defaultValue
        }
        self.btnShow.isHidden   = !self.isSecureTextField
        
        if self.isSecureTextField {
            self.rxIsShowContent.accept(false)
        }
    }
    
    private func setupBinding() {
        self.rxIsShowContent.asDriver().drive(onNext: { [weak self] (isShow) in
            guard let `self` = self else { return }
            if isShow {
                self.tfTextField.isSecureTextEntry = false
                self.btnShow.setImage(UIImage(named: "icon_eye"), for: .normal)
                return
            }
            
            self.tfTextField.isSecureTextEntry = true
            self.btnShow.setImage(UIImage(named: "icon_eye_crossed"), for: .normal)
        }).disposed(by: self.disposeBag)
        
        self.btnShow.rx.tap.asDriver().throttle(RxTimeInterval.milliseconds(500)).drive(onNext: {[weak self] (_) in
            guard let `self` = self else { return }
            self.rxIsShowContent.accept(!self.rxIsShowContent.value)
            print("Change show mode: \(self.rxIsShowContent.value)")
        }).disposed(by: self.disposeBag)
    }
}
