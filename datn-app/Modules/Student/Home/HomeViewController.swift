//
//  HomeViewController.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet weak var tbvContent               : UITableView!
    
    var selectedScheduleDate : ScheduleMode     = .Current
    let disposeBag                              = DisposeBag()
    
    /// `Reactive`
    let rxUserdata                              = BehaviorRelay<StudentModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalizedContent()
        /// `Call API`
        let currentUserID   = UserDefaultUtils.shared.getPreviousUsername().deCryptoData()
        if let username     = Int(currentUserID) {
            StudentRepository.shared.getUserByMSV(id: username) { [weak self] (studentModel, error) in
                SVProgressHUD.dismiss()
                guard let `self` = self else { return }
                if error != nil { return }
                self.rxUserdata.accept(studentModel)
            }
        }
    }
    
    private func initalizedContent() {
        self.setupView()
        self.handlerAction()
        self.setupBinding()
    }
    
    private func setupView() {
        self.view.backgroundColor   = Constant.Color.app_background
        self.setupNavigation()
        self.setupTableView()
        
        self.navigationItem.title                                       = "CSE E-link"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes    = textAttributes
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "icon_splash_background"), for: .top, barMetrics: .default)
        self.navigationController?.navigationBar.isTranslucent          = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreLocationService.shared.requestLocation()
    }
    
    private func setupNavigation() {
        let logoImage               = UIImage(named: "logo_circle_png")
        let logoImageView           = UIImageView(image: logoImage)
        logoImageView.frame         = CGRect(x:0.0,y:0.0, width:35,height:35)
        logoImageView.contentMode   = .scaleAspectFit
        let imageItem               = UIBarButtonItem(customView: logoImageView)
        let widthConstraint         = logoImageView.widthAnchor.constraint(equalToConstant: 35)
        let heightConstraint        = logoImageView.heightAnchor.constraint(equalToConstant: 35)
        heightConstraint.isActive   = true
        widthConstraint.isActive    = true
        self.navigationItem.leftBarButtonItem =  imageItem
        
        let notification                        = UIImage(named: "icon_notification")
        let notificationImgView                 = UIImageView(image: notification)
        notificationImgView.frame               = CGRect(x:0.0,y:0.0, width:35,height:35)
        notificationImgView.contentMode         = .scaleAspectFit
        let imgRightItem                        = UIBarButtonItem(customView: notificationImgView)
        let widthConstraintRight                = notificationImgView.widthAnchor.constraint(equalToConstant: 35)
        let heightConstraintRight               = notificationImgView.heightAnchor.constraint(equalToConstant: 35)
        heightConstraintRight.isActive          = true
        widthConstraintRight.isActive           = true
        self.navigationItem.rightBarButtonItem  =  imgRightItem
        self.navigationItem.rightBarButtonItem?.setBadge(text: "5+")
        bagdeCount                              = 5
    }
    
    private func setupTableView() {
        self.tbvContent.delegate        = self
        self.tbvContent.dataSource      = self
        self.tbvContent.separatorStyle  = .none
        self.tbvContent.bounces         = false
        self.tbvContent.alwaysBounceHorizontal  = false
        self.tbvContent.alwaysBounceVertical    = false
        self.tbvContent.register(UINib(nibName: "PopularFeatureCell", bundle: nil), forCellReuseIdentifier: "PopularFeatureCell")
        self.tbvContent.register(UINib(nibName: "DefaultHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultHomeTableViewCell")
        self.tbvContent.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        self.tbvContent.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        self.tbvContent.register(UINib(nibName: "HotNewsCell", bundle: nil), forCellReuseIdentifier: "HotNewsCell")
        self.tbvContent.register(UINib(nibName: "UrgenNotiCell", bundle: nil), forCellReuseIdentifier: "UrgenNotiCell")
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
        self.rxUserdata.asDriver().drive(onNext: { [weak self] (studentModel) in
            guard let `self` = self else { return }
            self.tbvContent.reloadData()
        }).disposed(by: self.disposeBag)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Header
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return HeaderCell()}
            cell.updateUI()
            cell.selectionStyle = .none
            cell.lblUsername.text   = self.rxUserdata.value?.name ?? "Sinh viên"
            cell.lblUsercode.text   = "Mã sinh viên: \(self.rxUserdata.value?.studentCode ?? "1851061743")"
            return cell
        }
        
        // Urgent noti
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UrgenNotiCell", for: indexPath) as? UrgenNotiCell else { return UrgenNotiCell()}
            cell.selectionStyle = .none
            cell.updateUI()
            return cell
        }
        
        // Popular Feature
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularFeatureCell", for: indexPath) as? PopularFeatureCell else { return PopularFeatureCell()}
            cell.updateUI()
            cell.selectionStyle = .none
            return cell
        }
        
        // Schedule
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return ScheduleCell()}
            cell.selectionStyle     = .none
            cell.updateUI()
            //            cell.heightForTbvRow    = self.tbvContent.bounds.size.height * (38/348)
            cell.setupButton()
            cell.rxChooseDay.accept(self.selectedScheduleDate)
            cell.reRenderTBV()
            cell.delegate           = self
            return cell
        }
        
        // Hot news
        if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotNewsCell", for: indexPath) as? HotNewsCell else { return HotNewsCell()}
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultHomeTableViewCell", for: indexPath) as? DefaultHomeTableViewCell else { return DefaultHomeTableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Header
        if indexPath.row == 0 {
            return self.tbvContent.frame.height * (130 / 663)
        }
        
        // Urgent noti
        if indexPath.row == 1 {
            return self.tbvContent.frame.height * (110 / 490)
        }
        
        // Popular Feature
        if indexPath.row == 2 {
            return self.tbvContent.frame.height * (140 / 490)
        }
        
        // Hot news
        if indexPath.row == 4 {
            return self.tbvContent.frame.height * (160 / 490)
        }
        
        return UITableView.automaticDimension
    }
}

extension HomeViewController : ScheduleCellDelegate {
    func onScheduleChange(mode: ScheduleMode) {
        self.selectedScheduleDate   = mode
        self.tbvContent.reloadData()
    }
}
