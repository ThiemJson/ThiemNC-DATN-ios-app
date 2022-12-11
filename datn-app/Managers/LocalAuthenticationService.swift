//
//  LocalAuthenticationService.swift
//  datn-app
//
//  Created by ThiemJason on 12/11/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import LocalAuthentication

class LocalAuthenticationService {
    private init() {}
    static let shared = LocalAuthenticationService()
    
    public func startAuthentication(reason: String, completion: @escaping (Bool) -> Void ) {
        let myContext = LAContext()
        let reason = reason
        var authError: NSError?
        
        /// If biometric avaiable, setup authen biometric
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            /// Set title cho các button của giao diện xác thực
            myContext.localizedCancelTitle = "Huỷ"
            
            /// Bắt đầu xác thực vân tay, nếu xác thực sai 3 lần liên tiếp hoặc tổng cộng 5 lần, show màn hình passcode của thiết bị.
            /// reason là message của giao diện xác thực. Ví dụ: "Sử dụng vân tay để đăng nhập vào app"
            myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                DispatchQueue.main.async {
                    switch success {
                    case true:
                        completion(true)
                    case false:
                        completion(false)
                    }
                }
            }
        }
    }
}
