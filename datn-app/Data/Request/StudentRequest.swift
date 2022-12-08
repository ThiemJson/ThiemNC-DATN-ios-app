//
//  StudentRequest.swift
//  datn-app
//
//  Created by ThiemJason on 12/8/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
struct StudentRequest : Codable {
    //    `UPDATE ${TABLE_SV} ` +
    //          ` SET MaSV = '${student_id}', ` +
    //          ` Hoten = '${name}',` +
    //          ` Ngaysinh = '${date_of_birth}',` +
    //          ` Gioitinh = '${gender}',` +
    //          ` MaThietbi = '${device_id}',` +
    //          ` MaFCM = '${fcm_id}',` +
    //          ` Matkhau = '${password}'` +
    //          ` WHERE ID = ${id};`;
    var studentCode             : String?
    var name                    : String?
    var dateOfBirth             : Date?
    var gender                  : String?
    var deviceCode              : String?
    var fcmCode                 : String?
    var password                : String?
    
    enum CodingKeys: String, CodingKey {
        case studentCode        = "MaSV"
        case name               = "Hoten"
        case dateOfBirth        = "Ngaysinh"
        case gender             = "Gioitinh"
        case deviceCode         = "MaThietbi"
        case fcmCode            = "MaFCM"
        case password           = "Matkhau"
    }
    
    init(from decoder: Decoder) throws {
        let values              = try decoder.container(keyedBy: CodingKeys.self)
        studentCode             = try values.decodeIfPresent(String.self, forKey: .studentCode)
        name                    = try values.decodeIfPresent(String.self, forKey: .name)
        dateOfBirth             = try values.decodeIfPresent(Date.self, forKey: .dateOfBirth)
        gender                  = try values.decodeIfPresent(String.self, forKey: .gender)
        deviceCode              = try values.decodeIfPresent(String.self, forKey: .deviceCode)
        fcmCode                 = try values.decodeIfPresent(String.self, forKey: .fcmCode)
        password                = try values.decodeIfPresent(String.self, forKey: .password)
    }
}
