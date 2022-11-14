//
//  TargetType.swift
//  MVVM Example
//
//  Created by Viet Anh Dang on 6/22/20.
//  Copyright © 2020 Cadory. All rights reserved.
//

import Foundation
import Alamofire

/// The protocol used to define the specifications necessary for a `MoyaProvider`.
public protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
//    /// The parameters to be encoded in the request.
//    var parameters: [String: Any]? { get }
//
//    /// The method used for parameter encoding.
//    var parameterEncoding: ParameterEncoding { get }
    
//    /// Provides stub data for use in testing.
//    var sampleData: Data { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool { get }
}

public extension TargetType {
    var validate: Bool {
        return false
    }
}

/// Represents a type of upload task.
public enum UploadType {
    
    /// Upload a file.
    case file(URL)
    
    /// Upload "multipart/fUtilsorm-data"
    case multipart([MultipartFormData])
}

/// Represents a type of download task.
public enum DownloadType {
    /// Download a file to a destination.
//    case request(Ala)
}

/// Represents an HTTP task.
public enum Task {
    
    /// A basic request task.
    case request
    
    /// An upload task.
    case upload(UploadType)
    
    /// A download task.
    case download(DownloadType)
}

