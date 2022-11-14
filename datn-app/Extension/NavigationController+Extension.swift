//
//  NavigationController+Extension.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 10/13/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import UIKit
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
