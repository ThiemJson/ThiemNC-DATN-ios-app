//
//  IndividualViewController.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit
import RxSwift
import RxCocoa

class IndividualViewController: UIViewController {
    @IBOutlet weak var tbvContent       : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   = Constant.Color.app_background
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.setupView()
        self.setupBinding()
        self.handlerAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        self.navigationController?.isToolbarHidden      = true
        self.tbvContent.delegate                        = self
        self.tbvContent.dataSource                      = self
        self.tbvContent.bounces                         = false
        self.tbvContent.alwaysBounceHorizontal          = false
        self.tbvContent.separatorStyle                  = .none
        self.tbvContent.register(UINib(nibName: "IndivitualHeaderCell", bundle: nil), forCellReuseIdentifier: "IndivitualHeaderCell")
        self.tbvContent.register(UINib(nibName: "OverviewCell", bundle: nil), forCellReuseIdentifier: "OverviewCell")
        self.tbvContent.register(UINib(nibName: "IndivitualBodyCell", bundle: nil), forCellReuseIdentifier: "IndivitualBodyCell")
    }
    
    private func setupBinding() {
        
    }
    
    private func handlerAction() {
        
    }
}

extension IndividualViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndivitualHeaderCell", for: indexPath) as? IndivitualHeaderCell else { return UITableViewCell() }
            cell.updateUI()
            return cell
        }
        
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? OverviewCell else { return UITableViewCell() }
            cell.updateUI()
            return cell
        }
        
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndivitualBodyCell", for: indexPath) as? IndivitualBodyCell else { return UITableViewCell() }
            cell.updateUI()
            
            let topInset    = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
            let navHeight   = self.navigationController?.navigationBar.frame.height ?? 0
            let tbvHeight   = self.tbvContent.frame.height - topInset - navHeight
            cell.constRowHeight.constant    = tbvHeight * ( 43 / 514 )
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.tbvContent.frame.height * (223 / 538)
        }
        
        if indexPath.row == 1 {
            return self.tbvContent.frame.height * (80 / 538)
        }
        
        if indexPath.row == 2 {
            return self.tbvContent.frame.height * (410 / 765)
        }
        
        return UITableView.automaticDimension
    }
}
