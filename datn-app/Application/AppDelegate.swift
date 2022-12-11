//
//  AppDelegate.swift
//  datn-app
//
//  Created by ThiemJason on 11/18/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Keyboard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
        let loginVC = LoginViewController()
        let navViewController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navViewController
        
        /// `Sửa lỗi navigation bar đổi màu`
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font: UIFont.getOpenSansSemiBoldFontTitle()
            ]
            
            navigationBarAppearance.backgroundColor             = .clear
            navigationBarAppearance.shadowColor                 = .clear
            UINavigationBar.appearance().standardAppearance     = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance      = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance   = navigationBarAppearance
            
            let tabBarApperance                         = UITabBarAppearance()
            tabBarApperance.shadowColor                 = .clear
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor             = UIColor.clear
            UITabBar.appearance().scrollEdgeAppearance  = tabBarApperance
            UITabBar.appearance().standardAppearance    = tabBarApperance
        }
        
        /// `Request location permission`
        CoreLocationService.shared.requestAlwaysAuth()
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

