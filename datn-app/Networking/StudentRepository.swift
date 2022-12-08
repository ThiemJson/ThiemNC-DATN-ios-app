//
//  StudentRepository.swift
//  datn-app
//
//  Created by ThiemJason on 12/8/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudentRepository {
    static let shared   = StudentRepository()
    let decoder         = JSONDecoder()
    private init() {}
    
    /// `Lấy thông tin người dùng`
    public func getUserByMSV( loginRequest: LoginRequest, completion: @escaping (StudentResponse?) -> Void = { _ in } ) {
        let username = loginRequest.username ?? ""
        Provider.shared.requestAPI(api: .student, subPathAPI: "msv/\(username)") {(success, IsFailResponseError, data) -> (Void) in
            if success && !IsFailResponseError , let data = data {
                let studentJson = JSON(data)["data"][0]
                completion(StudentResponse(from: studentJson))
                return
            }
            completion(nil)
        }
    }
}
