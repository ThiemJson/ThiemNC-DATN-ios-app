//
//  LoginResponse.swift
//  datn-app
//
//  Created by ThiemJason on 12/8/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
struct LoginResponse : Codable {
    var username                : String?
    var password                : String?
    var deviceCode              : String?
    var type                    : Int?
    
    enum CodingKeys: String, CodingKey {
        case username           = "username"
        case password           = "password"
        case deviceCode         = "deviceCode"
        case type               = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values              = try decoder.container(keyedBy: CodingKeys.self)
        username                = try values.decodeIfPresent(String.self, forKey: .username)
        password                = try values.decodeIfPresent(String.self, forKey: .password)
        deviceCode              = try values.decodeIfPresent(String.self, forKey: .deviceCode)
        type                    = try values.decodeIfPresent(Int.self, forKey: .type)
    }
}
