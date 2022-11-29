//
//  FeatureViewController.swift
//  datn-app
//
//  Created by ThiemJason on 28/11/2022.
//

import UIKit
import RxCocoa
import RxSwift

class FeatureViewController: UIViewController {
    @IBOutlet weak var tbvContent           : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalizedContent()
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "icon_splash_background"), for: .top, barMetrics: .default)
        self.navigationController?.navigationBar.isTranslucent          = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupNavigation() {
        let label = UILabel()
        label.textColor     = UIColor.white
        label.text          = "Tiện ích số";
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
    
    private func setupTableView() {
        self.tbvContent.alwaysBounceVertical    = false
        self.tbvContent.delegate        = self
        self.tbvContent.dataSource      = self
        self.tbvContent.bounces         = false
        self.tbvContent.alwaysBounceHorizontal  = false
        self.tbvContent.separatorStyle  = .none
        self.tbvContent.alwaysBounceVertical    = false
        self.tbvContent.register(UINib(nibName: "HotNewsCell", bundle: nil), forCellReuseIdentifier: "HotNewsCell")
        self.tbvContent.register(UINib(nibName: "FeatureBodyCell", bundle: nil), forCellReuseIdentifier: "FeatureBodyCell")
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
        
    }
}

extension FeatureViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotNewsCell", for: indexPath) as? HotNewsCell else { return HotNewsCell()}
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureBodyCell", for: indexPath) as? FeatureBodyCell else { return FeatureBodyCell()}
            cell.selectionStyle             = .none
            cell.constRowHeight.constant    = self.tbvContent.frame.height * ( 43 / 514 )
            cell.updateUI()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Hot news
        if indexPath.row == 0 {
            return self.tbvContent.frame.height * (160 / 490)
        }
        
        return UITableView.automaticDimension
    }
}
