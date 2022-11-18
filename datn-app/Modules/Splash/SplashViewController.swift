//
//  SplashViewController.swift
//  datn-app
//
//  Created by ThiemJason 11/18/22.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var lblHello         : UILabel!
    @IBOutlet weak var vLottie          : AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblName.textColor      = .white
        self.lblHello.textColor     = .white
        self.lblName.font           = UIFont.getOpenSansBoldFont(size: 30)
        self.lblHello.font          = UIFont.getOpenSansBoldFont(size: 24)
        
        self.vLottie.contentMode        = .scaleAspectFill
        self.vLottie.loopMode           = .playOnce
        self.vLottie.animationSpeed     = 1.0
        self.vLottie.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let rootWindow = self.view.window {
                rootWindow.rootViewController   = RootTabBarViewController()
                let options: UIView.AnimationOptions = .transitionFlipFromRight
                let duration: TimeInterval = 0.5
                UIView.transition(with: rootWindow, duration: duration, options: options, animations: {}, completion:
                { completed in
                    // maybe do something on completion here
                })
            }
        }
    }
}
