//
//  UIViewController+Extension.swift
//  datn-app
//
//  Created by ThiemJason on 12/11/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
