//
//  RootTabBarViewController.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit
import RxSwift
import RxCocoa

class RootTabBarViewController: UITabBarController {
    let disposeBag              = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        // Fix bug tabbar background color is turn black in iOS 15.0 or above
        if #available(iOS 15.0, *) {
            tabBar.backgroundColor = .white
        }
        
        self.setupTabbar()
    }
    
    public func setupTabbar(){
        
        let homeVC                              = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image                 = UIImage(named: "tabbar_home_unselect")
        homeVC.tabBarItem.selectedImage         = UIImage(named: "tabbar_home_select")
        homeVC.title                            = "Trang chủ"
        
        let learningVC                          = UINavigationController(rootViewController: LearningViewController())
        learningVC.tabBarItem.image             = UIImage(named: "tabbar_learning_unselect")
        learningVC.tabBarItem.selectedImage     = UIImage(named: "tabbar_learning_select")
        learningVC.title                        = "Góc học tập"
        
        let notiVC                              = UINavigationController(rootViewController: FeatureViewController())
        notiVC.tabBarItem.image                 = UIImage(named: "tabbar_feature_unselect")
        notiVC.tabBarItem.selectedImage         = UIImage(named: "tabbar_feature_select")
        notiVC.title                            = "Tiện ích"
        
        let individualVC                        = UINavigationController(rootViewController: IndividualViewController())
        individualVC.tabBarItem.image           = UIImage(named: "tabbar_user_unselect")
        individualVC.tabBarItem.selectedImage   = UIImage(named: "tabbar_user_select")
        individualVC.title                      = "Cá nhân"
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tabar_selected], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tabar_unselected], for: .normal)
        
        self.viewControllers = [homeVC, learningVC, notiVC , individualVC]
        
        for item in self.tabBar.items! {
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
        }
    }
}
