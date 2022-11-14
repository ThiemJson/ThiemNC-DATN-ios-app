//
//  ViewController+Extension.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 7/3/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import UIKit
extension UIViewController {

    /// This function sets an image as the background of the view controller
    ///
    /// - Parameters:
    ///   - imageName: name of image
    ///   - contentMode:
    ///          .scaleAspectFill
    ///          .scaleAspectFit
    ///          .scaleToFill
    func setBackgroundImage(_ imageName: String, contentMode: UIView.ContentMode) {
        let darkOverlay = UIView(frame: UIScreen.main.bounds)
        darkOverlay.backgroundColor = Constant.Color.black_opa_50
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = contentMode
        
        
        self.view.insertSubview(backgroundImage, at: 0)
        self.view.insertSubview(darkOverlay, at: 1)
    }
    func noTextNavigation(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func addTxtFieldDesign(textfield: UITextField, placeHolder: String, color: UIColor, backgroundColor: UIColor = Constant.Color.lightGray_opa_25,cornerRadius: CGFloat) {
        textfield.textColor = color
        textfield.tintColor = color
        textfield.addPadding(padding: .left(10))
        textfield.addCornerAndColor(color: backgroundColor, cornerRadius: cornerRadius)
        textfield.addPlaceHolder(content: placeHolder, color: color)
    }
    func addTxtPhoneFieldDesign(textfield: UITextField, placeHolder: String, color: UIColor) {
        textfield.textColor = color
        textfield.addPadding(padding: .left(25))
        textfield.addCornerAndColor(color: Constant.Color.lightGray_opa_25, cornerRadius: 10)
        textfield.addPlaceHolder(content: placeHolder, color: color)
    }
    
    func addTxtFieldDesign(textfield: UITextField, placeHolder: String) {
        textfield.textColor = Constant.Color.dark_blue
        textfield.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: Constant.Color.gray_text_opa])
    }
    
    func addTxtTimeStampPickerDesign(textfield: UITextField, placeHolder: String, cornerColor: UIColor, txtColor: UIColor, leftPadding: CGFloat){
        textfield.textColor = txtColor
        textfield.tintColor = txtColor
        textfield.addPadding(padding: .left(leftPadding))
        textfield.layer.cornerRadius = 15
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = cornerColor.cgColor
        textfield.layer.backgroundColor = Constant.Color.hex_9EB6C3_op20.cgColor
    }
    
    func setBackgroundImageWithHeight(_ imageName: String, contentMode: UIView.ContentMode, height: Int) {
        let darkOverlay = UIView(frame: UIScreen.main.bounds)
        
        let frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: height)
        
        let backgroundImage = UIImageView(frame: frame)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = contentMode
        self.view.insertSubview(backgroundImage, at: 0)
        self.view.insertSubview(darkOverlay, at: 1)
    }
    
    func addViewDesign(backGround: UIColor, cornerRadius: CGFloat, view: UIView){
        view.backgroundColor = backGround
        view.layer.cornerRadius = cornerRadius
    }
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    var isIpadLandsScape: Bool {
        if isPad {
            let orientation = UIApplication.shared.statusBarOrientation.isLandscape
            return orientation
        }
        return false
    }
    
    var isIpadPortrait: Bool {
        if isPad {
            let orientation = UIApplication.shared.statusBarOrientation.isPortrait
            return orientation
        }
        return false
    }
    
    var isLandScape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    var currentMessageId: String {
        let date = Date()
        return("\(UserDefaultUtils.shared.getCurrentUserId())_\(date.millisecondsSince1970)")
    }
}

