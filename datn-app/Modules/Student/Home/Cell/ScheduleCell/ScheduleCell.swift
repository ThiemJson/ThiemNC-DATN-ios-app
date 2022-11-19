//
//  ScheduleCell.swift
//  datn-app
//
//  Created by ThiemJason on 11/19/22.
//

import UIKit
import RxSwift
import RxCocoa

enum ScheduleMode {
    case Current
    case Tomorrow
    case AfterTomorrow
}

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var vContentView             : UIView!
    @IBOutlet weak var lblTitle                 : UILabel!
    @IBOutlet weak var vContentSchedule         : UIView!
    
    @IBOutlet weak var vBtnCurrentDay           : UIView!
    @IBOutlet weak var lblCurrent               : UILabel!
    
    @IBOutlet weak var vBtnTomorrow             : UIView!
    @IBOutlet weak var lblTomorrow              : UILabel!
    
    @IBOutlet weak var vBtnAfterTomorrow        : UIView!
    @IBOutlet weak var lblAfterTomorrow         : UILabel!
    @IBOutlet weak var lblNoSchedule            : UILabel!
    
    let rxChooseDay                             = BehaviorRelay<ScheduleMode>(value: .Current)
    let disposeBag                              = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initializedContent()
        self.setupBinding()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func initializedContent() {
        self.vContentView.backgroundColor   = Constant.Color.app_background
        self.lblTitle.font                  = UIFont.getOpenSansBoldFont(size: 15)
        self.lblTitle.textColor             = Constant.Color.dark_blue
        self.lblTitle.text                  = "Lịch học"
        
        self.vContentSchedule.layer.cornerRadius    = CGFloat(Constant.Values.commonRadius)
        self.vContentSchedule.clipsToBounds         = true
        self.vContentSchedule.backgroundColor       = .white
        self.lblNoSchedule.textColor                = Constant.Color.gray_text_opa
        self.lblNoSchedule.font                     = UIFont.getOpenSansBoldFont(size: 15)
    }
    
    private func setupBinding() {
        self.rxChooseDay.asDriver().drive(onNext: { [weak self] (mode) in
            guard let `self` = self else { return }
            if mode == .Current {
                self.setSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setUnSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setUnSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
                return
            }
            
            if mode == .Tomorrow {
                self.setUnSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setUnSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
                return
            }
            
            if mode == .AfterTomorrow {
                self.setUnSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setUnSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
                return
            }
        }).disposed(by: self.disposeBag)
        
        self.vBtnCurrentDay.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxChooseDay.accept(.Current)
        }).disposed(by: self.disposeBag)
        
        self.vBtnTomorrow.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxChooseDay.accept(.Tomorrow)
        }).disposed(by: self.disposeBag)
        
        self.vBtnAfterTomorrow.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxChooseDay.accept(.AfterTomorrow)
        }).disposed(by: self.disposeBag)
    }
    
    private func setSelectedDate(uiView: UIView, uiLabel: UILabel) {
        uiView.backgroundColor          = Constant.Color.dark_blue
        uiLabel.textColor               = .white
    }
    
    private func setUnSelectedDate(uiView: UIView, uiLabel: UILabel) {
        uiView.backgroundColor          = .clear
        uiLabel.textColor               = Constant.Color.gray_text_opa
    }
    
    func updateUI() {
        self.setupButton(uiViews: [self.vBtnTomorrow, self.vBtnCurrentDay, self.vBtnAfterTomorrow])
        
        self.lblCurrent.textColor           = .white
        self.lblAfterTomorrow.textColor     = .white
        self.lblTomorrow.textColor          = .white
        
        self.lblCurrent.font                = UIFont.getOpenSansBoldFont(size: 12)
        self.lblAfterTomorrow.font          = UIFont.getOpenSansBoldFont(size: 12)
        self.lblTomorrow.font               = UIFont.getOpenSansBoldFont(size: 12)
    }
    
    private func setupButton(uiViews: [UIView]) {
        uiViews.forEach { (view) in
            view.clipsToBounds           = true
            view.backgroundColor         = Constant.Color.dark_blue
            view.layer.cornerRadius      = view.frame.height / 2
        }
    }
}
