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

protocol ScheduleCellDelegate : NSObjectProtocol {
    func onScheduleChange(mode: ScheduleMode)
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
    @IBOutlet weak var tbvSchedule              : UITableView!
    @IBOutlet weak var vNoData: UIView!
    
    let rxChooseDay                             = BehaviorRelay<ScheduleMode>(value: .Current)
    let disposeBag                              = DisposeBag()
    var heightForTbvRow : CGFloat               = 70
    var listSchedule                            = [1,2,3,4,5,6]
    weak var delegate                           : ScheduleCellDelegate?
    @IBOutlet weak var constTbvHeight           : NSLayoutConstraint!
    
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
        
        self.tbvSchedule.register(UINib(nibName: "ScheduleTableCell", bundle: nil), forCellReuseIdentifier: "ScheduleTableCell")
        self.tbvSchedule.delegate                       = self
        self.tbvSchedule.dataSource                     = self
        self.tbvSchedule.separatorStyle                 = .singleLine
        self.tbvSchedule.showsVerticalScrollIndicator   = false
    }
    
    private func setupBinding() {
        self.rxChooseDay.asDriver().drive(onNext: { [weak self] (mode) in
            guard let `self` = self else { return }
            switch mode {
            case .Current:
                self.setSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setUnSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setUnSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
            case .Tomorrow:
                self.setUnSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setUnSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
            case .AfterTomorrow:
                self.setUnSelectedDate(uiView: self.vBtnCurrentDay, uiLabel: self.lblCurrent)
                self.setUnSelectedDate(uiView: self.vBtnTomorrow, uiLabel: self.lblTomorrow)
                self.setSelectedDate(uiView: self.vBtnAfterTomorrow, uiLabel: self.lblAfterTomorrow)
            }
        }).disposed(by: self.disposeBag)
        
        self.vBtnCurrentDay.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.listSchedule = [1,2,3,4,5,6]
            self.rxChooseDay.accept(.Current)
            self.reRenderTBV()
            self.delegate?.onScheduleChange(mode: .Current)
        }).disposed(by: self.disposeBag)
        
        self.vBtnTomorrow.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.listSchedule = [1,1]
            self.rxChooseDay.accept(.Tomorrow)
            self.reRenderTBV()
            self.delegate?.onScheduleChange(mode: .Tomorrow)
        }).disposed(by: self.disposeBag)
        
        self.vBtnAfterTomorrow.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.listSchedule = []
            self.rxChooseDay.accept(.AfterTomorrow)
            self.reRenderTBV()
            self.delegate?.onScheduleChange(mode: .AfterTomorrow)
        }).disposed(by: self.disposeBag)
    }
    
    func reRenderTBV() {
        self.constTbvHeight.constant        = self.listSchedule.isEmpty ? 150 : max(CGFloat(self.listSchedule.count) * self.heightForTbvRow, 150)
        self.tbvSchedule.reloadData()
        self.vNoData.isHidden               = self.listSchedule.count > 0
        self.tbvSchedule.isHidden           = self.listSchedule.isEmpty
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
        self.lblCurrent.textColor           = .white
        self.lblAfterTomorrow.textColor     = .white
        self.lblTomorrow.textColor          = .white
        
        self.lblCurrent.font                = UIFont.getOpenSansBoldFont(size: 12)
        self.lblAfterTomorrow.font          = UIFont.getOpenSansBoldFont(size: 12)
        self.lblTomorrow.font               = UIFont.getOpenSansBoldFont(size: 12)
    }
    
    func setupButton() {
        let uiViews = [self.vBtnTomorrow, self.vBtnCurrentDay, self.vBtnAfterTomorrow]
        uiViews.forEach { (view) in
            view?.clipsToBounds           = true
            view?.backgroundColor         = Constant.Color.dark_blue
            view?.layer.cornerRadius      = CGFloat(Constant.Values.commonRadius * 2)
        }
    }
}

extension ScheduleCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.heightForTbvRow)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableCell", for: indexPath) as? ScheduleTableCell else
        { return UITableViewCell() }
        return cell
    }
}
