//
//  HomeViewController.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tbvContent       : UITableView!
    let dumbData                        = ["1","2", "3","1","2", "3","1","2", "31","2", "3","1","2", "3","1","2", "3"]
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
        
        self.navigationItem.title                                       = "CSE Attendance"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes    = textAttributes
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "icon_splash_background"), for: .top, barMetrics: .default)
        self.navigationController?.navigationBar.isTranslucent          = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    }
    
    private func setupTableView() {
        self.tbvContent.delegate        = self
        self.tbvContent.dataSource      = self
        self.tbvContent.separatorStyle  = .none
        self.tbvContent.alwaysBounceVertical    = false
        self.tbvContent.register(UINib(nibName: "PopularFeatureCell", bundle: nil), forCellReuseIdentifier: "PopularFeatureCell")
        self.tbvContent.register(UINib(nibName: "DefaultHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultHomeTableViewCell")
        self.tbvContent.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
    }
    
    private func handlerAction() {
        
    }
    
    private func setupBinding() {
        
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dumbData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Header
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else { return HeaderCell()}
            cell.updateUI()
            return cell
        }
        
        // Popular Feature
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularFeatureCell", for: indexPath) as? PopularFeatureCell else { return PopularFeatureCell()}
            cell.updateUI()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultHomeTableViewCell", for: indexPath) as? DefaultHomeTableViewCell else { return DefaultHomeTableViewCell()}
        cell.lblContent.text        = self.dumbData[indexPath.row]
        cell.lblContent.textColor   = Constant.Color.dark_blue
        cell.selectionStyle         = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.tbvContent.frame.height * (130 / 663)
        }
        
        if indexPath.row == 1 {
            return self.tbvContent.frame.height * (140 / 490)
        }
        
        return UITableView.automaticDimension
    }
}
