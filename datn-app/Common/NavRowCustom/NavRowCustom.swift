//
//  NavRowCustom.swift
//  datn-app
//
//  Created by ThiemJason on 11/22/22.
//

import UIKit
import RxCocoa
import RxSwift

class NavRowCustom: UIView {
    // MARK: Setting UI View
    @IBOutlet var mainView              : UIView!
    @IBOutlet weak var imgLeftIcon      : UIImageView!
    @IBOutlet weak var imgRightIcon     : UIImageView!
    @IBOutlet weak var lblContent       : UILabel!
    @IBOutlet weak var vTopLine         : UIView!
    @IBOutlet weak var vBotLine         : UIView!
    
    let rxLeftIconClicked: PublishSubject<Bool>   = PublishSubject()
    let rxRightIconClicked: PublishSubject<Bool>  = PublishSubject()
    let disposeBag                              = DisposeBag()
    
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
        Bundle.main.loadNibNamed("NavRowCustom", owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame                     = self.bounds
        self.mainView.autoresizingMask          = [.flexibleHeight, .flexibleWidth]
        self.updateUI()
        self.setupBinding()
        
        self.vBotLine.backgroundColor           = Constant.Color.app_background
        self.vTopLine.backgroundColor           = Constant.Color.app_background
        self.lblContent.textColor               = Constant.Color.dark_blue
        self.lblContent.font                    = UIFont.getOpenSansSemiBoldFontDefault()
        
        self.imgRightIcon.tintColor             = Constant.Color.gray_light
    }
    
    func updateUI() {
        
    }
    
    func setupBinding() {
        self.imgLeftIcon.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxLeftIconClicked.onNext(true)
        }).disposed(by: self.disposeBag)
        
        self.imgRightIcon.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxRightIconClicked.onNext(true)
        }).disposed(by: self.disposeBag)
    }
}
