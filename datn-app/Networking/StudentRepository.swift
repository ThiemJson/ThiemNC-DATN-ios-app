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
    
    /// `Lấy thông tin người dùng` = `MSV`
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
    
    /// `Lấy thông tin người dùng` = `deviceCode`
    public func getUserByDeviceCode( loginRequest: LoginRequest, completion: @escaping (StudentResponse?) -> Void = { _ in } ) {
        let deviceCode = loginRequest.deviceCode ?? ""
        Provider.shared.requestAPI(api: .student, subPathAPI: "msv/\(deviceCode)") {(success, IsFailResponseError, data) -> (Void) in
            if success && !IsFailResponseError , let data = data {
                let studentJson = JSON(data)["data"][0]
                completion(StudentResponse(from: studentJson))
                return
            }
            completion(nil)
        }
    }
    
    public func updateStudent( studentRequest: StudentResponse?, completion: @escaping (Bool) -> Void ) {
        Provider.shared.requestAPI(api: .updateStudent, parameters: studentRequest?.setParams()) {(success, IsFailResponseError, data) -> (Void) in
            if success && !IsFailResponseError , let data = data {
                completion(true)
                return
            }
            completion(false)
        }
    }
}
