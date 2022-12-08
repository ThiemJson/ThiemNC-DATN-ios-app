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
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

