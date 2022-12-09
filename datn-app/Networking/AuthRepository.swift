//
//  AuthRepository.swift
//  datn-app
//
//  Created by ThiemJason on 12/9/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuthRepository {
    static let shared   = AuthRepository()
    let decoder         = JSONDecoder()
    private init() {}
    
    public func login( loginRequest: LoginRequest, completion: @escaping (StudentModel?, ProviderError?) -> Void = { (_,_) in } ) {
        Provider.shared.requestAPI(api: .auth, parameters: loginRequest.setParams()) {(success, IsFailResponseError, data) -> (Void) in
            if success && !IsFailResponseError , let data = data {
                let studentJson = JSON(data)["data"][0]
                completion(StudentModel(from: studentJson), nil)
                return
            }
            
            /// `Fail with errorCode`
            if let data = data {
                let errorJson = JSON(data)["data"]
                completion(nil, ProviderError.getErrorCode(errorJson["errorCode"].stringValue))
            }
        }
    }
}
