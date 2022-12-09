//
//  StudentModel.swift
//  datn-app
//
//  Created by ThiemJason on 12/8/22.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

struct StudentModel : Codable {
    //    `UPDATE ${TABLE_SV} ` +
    //          ` SET MaSV = '${student_id}', ` +
    //          ` Hoten = '${name}',` +
    //          ` Ngaysinh = '${date_of_birth}',` +
    //          ` Gioitinh = '${gender}',` +
    //          ` MaThietbi = '${device_id}',` +
    //          ` MaFCM = '${fcm_id}',` +
    //          ` Matkhau = '${password}'` +
    //          ` WHERE ID = ${id};`;
    var id                      : Int?
    var studentCode             : String?
    var name                    : String?
    var dateOfBirth             : String?
    var gender                  : String?
    var deviceCode              : String?
    var fcmCode                 : String?
    var password                : String?
    
    enum CodingKeys: String, CodingKey {
        case id                 = "ID"
        case studentCode        = "MaSV"
        case name               = "Hoten"
        case dateOfBirth        = "Ngaysinh"
        case gender             = "Gioitinh"
        case deviceCode         = "MaThietbi"
        case fcmCode            = "MaFCM"
        case password           = "Matkhau"
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let values              = try decoder.container(keyedBy: CodingKeys.self)
        id                      = try values.decodeIfPresent(Int.self, forKey: .id)
        studentCode             = try values.decodeIfPresent(String.self, forKey: .studentCode)
        name                    = try values.decodeIfPresent(String.self, forKey: .name)
        dateOfBirth             = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        gender                  = try values.decodeIfPresent(String.self, forKey: .gender)
        deviceCode              = try values.decodeIfPresent(String.self, forKey: .deviceCode)
        fcmCode                 = try values.decodeIfPresent(String.self, forKey: .fcmCode)
        password                = try values.decodeIfPresent(String.self, forKey: .password)
    }
    
    init(from json: JSON) {
        id                      = json["ID"].int
        studentCode             = json["MaSV"].string
        name                    = json["Hoten"].string
        dateOfBirth             = json["Ngaysinh"].string
        gender                  = json["Gioitinh"].string
        deviceCode              = json["MaThietbi"].string
        fcmCode                 = json["MaFCM"].string
        password                = json["Matkhau"].string
    }
}
