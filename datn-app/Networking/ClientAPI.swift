//
//  ClientAPI.swift
//  MVVM Example
//
//  Created by Viet Anh Dang on 6/22/20.
//  Copyright © 2020 Cadory. All rights reserved.
//

import Foundation
import Alamofire

enum ClientApi {
    
}

extension ClientApi: TargetType {
    
    /// The target's base `URL`.
    var baseURL: String {
        return Constant.Router.apiPrefix
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        return ""
    }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod {
        return .post
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
}
