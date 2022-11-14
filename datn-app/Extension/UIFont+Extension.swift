//
//  UIFont+Extension.swift
//  OneHome
//
//  Created by Tấn Tạ Đình on 11/2/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import UIKit
extension UIFont {
    static func getRobotoRegularFont(sizeFont size:CGFloat) -> UIFont {
        return UIFont.init(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func getOpenSansRegularFontDefault() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 19) ?? UIFont.systemFont(ofSize: 19)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 15) ?? UIFont.systemFont(ofSize: 15)
        }
    }
    
    static func getOpenSansSemiBoldFontDefault() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 19) ?? UIFont.systemFont(ofSize: 19)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 15) ?? UIFont.systemFont(ofSize: 15)
        }
    }
    
    static func getOpenSansRegularFontSmall() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 17) ?? UIFont.systemFont(ofSize: 17)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 13) ?? UIFont.systemFont(ofSize: 13)
        }
    }
    
    static func getOpenSansSemiBoldFontSmall() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 17) ?? UIFont.systemFont(ofSize: 17)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 13) ?? UIFont.systemFont(ofSize: 13)
        }
    }
    
    static func getOpenSansRegularFontReallySmall() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 14) ?? UIFont.systemFont(ofSize: 14)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 11) ?? UIFont.systemFont(ofSize: 11)
        }
    }
    
    static func getOpenSansRegularFontLarge() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 21) ?? UIFont.systemFont(ofSize: 21)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
    }
    
    static func getOpenSansSemiBoldFontLarge() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 21) ?? UIFont.systemFont(ofSize: 21)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
    }
    
    static func getOpenSansSemiBoldFontTitle() -> UIFont {
        if isPad {
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 24) ?? UIFont.systemFont(ofSize: 24)
        }else{
            return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 19) ?? UIFont.systemFont(ofSize: 19)
        }
    }
    
    static func getOpenSansRegularFontIpadDefault() -> UIFont {
        return UIFont.init(name: Constant.Font.OpenSans_Regular, size: 17) ?? UIFont.systemFont(ofSize: 17)
    }
    
    static func getOpenSansSemiBoldFontIpadDefault() -> UIFont {
        return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: 18) ?? UIFont.systemFont(ofSize: 18)
    }
    
    static func getOpenSansSemiBoldFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: Constant.Font.OpenSans_SemiBold, size: size) ?? UIFont.systemFont(ofSize: 17)
    }
    
    static func getOpenSansRegularFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: Constant.Font.OpenSans_Regular, size: size) ?? UIFont.systemFont(ofSize: 17)
    }
    
    static func getOpenSansBoldFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: Constant.Font.OpenSans_Bold, size: size) ?? UIFont.systemFont(ofSize: 17)
    }
}
