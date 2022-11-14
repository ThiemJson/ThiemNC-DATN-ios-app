//  NSObject+Extension.swift
//  OneHome
//
//  Created by Atula on 7/10/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import Foundation
extension NSObject {
    
    func log(_ message: String, _ funcName: String = #function) {
        #if DEBUG
            print("debugLog >>> \(NSStringFromClass(self.classForCoder)) >>> \(funcName) >>> \(message)")
        #endif
    }
    
}
