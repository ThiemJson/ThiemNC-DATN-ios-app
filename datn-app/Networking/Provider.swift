//
//  Provider.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 7/9/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Photos
import RxCocoa
import RxSwift

typealias RequestCompletion = ((_ success: Bool, _ IsFailResponseError: Bool, _ data: Any?) -> (Void))?

enum ProviderError: String {
    case IDNotfound = "error.auth.IDNotfound"
    case PasswordIncorrect = "error.auth.passwordIncorrect"
    case DeviceInuse = "error.auth.deviceInUse"
    case AccountInuse = "error.auth.accountInUse"
    case NetworkError = "error.network.error"
    
    static func getErrorCode(_ errorCode: String) -> ProviderError {
        switch errorCode {
        case ProviderError.IDNotfound.rawValue:
            return ProviderError.IDNotfound
        case ProviderError.PasswordIncorrect.rawValue:
            return ProviderError.PasswordIncorrect
        case ProviderError.DeviceInuse.rawValue:
            return ProviderError.DeviceInuse
        case ProviderError.AccountInuse.rawValue:
            return ProviderError.AccountInuse
        case ProviderError.NetworkError.rawValue:
            return ProviderError.NetworkError
        default:
            return ProviderError.NetworkError
        }
    }
}

class Provider {
    static let shared  = Provider()
    
    var alamofireManager: Alamofire.Session?
    let rxLoading: PublishSubject<Bool?> = PublishSubject()
    
    fileprivate var request: Request?
    
    fileprivate let networkTimeout: TimeInterval = 60.0
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkTimeout
        configuration.timeoutIntervalForResource = networkTimeout
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    fileprivate func getDefaultHeaderTypeJSON() -> HTTPHeaders {
        var headers = HTTPHeaders()
        if let accessToken = UserDefaultUtils.shared.getAccessToken() {
            headers["Authorization"] = "Bearer " + accessToken
        }
        return headers
    }
    
    func cancel() {
        request?.cancel()
    }
}

extension Provider {
    
    //MARK: Common REQUEST API
    /// Creates a `RequestAPI` normal with optinal `subpath` `parameters` `headers` `headers`
    ///
    /// - Parameters:
    ///   - api:                `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - subPathAPI:         `subPathAPI` for the `api`. `nil` by default. (Exp: query?..)
    ///   - parameters:         `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` bydefault.
    ///   - headers:            `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - encoding:           `encoding` value to be used by the returned `DataRequest`. `JSONEncoding.prettyPrinted` by default.
    ///   - completion:         `RequestCompletion` `RequestCompletion` by default
    ///
    /// - Returns:              `Void`.
    func requestAPI( api: ClientApi,
                     subPathAPI: String? = nil,
                     parameters: [String : Any]? = nil,
                     headers: HTTPHeaders? = nil,
                     encoding: ParameterEncoding? = nil,
                     completion: RequestCompletion) {
        
        /// URL
        let url: String = {
            if let subPathAPI = subPathAPI, subPathAPI != "" {
                return api.baseURL + api.path + "/\(subPathAPI)"
            } else {
                return api.baseURL + api.path
            }
        }()
        
        /// Header
        let finalHeaders: HTTPHeaders = {
            if let headers = headers {
                return headers
            }
            return getDefaultHeaderTypeJSON()
        }()
        
        /// Encoding
        let finalEncoding: ParameterEncoding = {
            if let encoding = encoding {
                return encoding
            }
            return JSONEncoding.prettyPrinted
        }()
        
        /// Show loading
        self.rxLoading.onNext(true)
        
        alamofireManager?.request(url,
                                  method: api.method,
                                  parameters: parameters,
                                  encoding: finalEncoding,
                                  headers: finalHeaders)
        .cURLDescription(calling: { (curl) in
            print(curl)
        })
        .responseJSON(completionHandler: { (response) in
            print("---------------------------------")
            
            /// Dismiss Loading
            self.rxLoading.onNext(false)
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200:
                    completion?(true, false, data)
                    
                case 400:
                    completion?(false, false, data)
                    
                case 401:
                    break
                case 404:
                    completion?(false, false, nil)
                default:
                    completion?(false, false, nil)
                }
                
            case .failure(_):
                switch statusCode {
                case 401:
                    break
                case 404:
                    completion?(false, false, nil)
                default:
                    print("============ Error ==============")
                    completion?(false, true, nil)
                }
            }
        })
    }
    
    
    //MARK: REQUEST API no Response
    /// Creates a `RequestAPI` normal with optinal `subpath` `parameters` `headers` `headers`
    ///
    /// - Parameters:
    ///   - api:                `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - subPathAPI:         `subPathAPI` for the `api`. `nil` by default. (Exp: query?..)
    ///   - parameters:         `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` bydefault.
    ///   - headers:            `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - encoding:           `encoding` value to be used by the returned `DataRequest`. `JSONEncoding.prettyPrinted` by default.
    ///   - completion:         `RequestCompletion` `RequestCompletion` by default
    ///
    /// - Returns:              `Void`.
    func requestAPI_NoResponse( api: ClientApi,
                                subPathAPI: String? = nil,
                                parameters: [String : Any]? = nil,
                                headers: HTTPHeaders? = nil,
                                encoding: ParameterEncoding? = nil,
                                completion: RequestCompletion) {
        
        /// URL
        let url: String = {
            if let subPathAPI = subPathAPI, subPathAPI != "" {
                return api.baseURL + api.path + "/\(subPathAPI)"
            } else {
                return api.baseURL + api.path
            }
        }()
        
        /// Header
        let finalHeaders: HTTPHeaders = {
            if let headers = headers {
                return headers
            }
            return getDefaultHeaderTypeJSON()
        }()
        
        /// Encoding
        let finalEncoding: ParameterEncoding = {
            if let encoding = encoding {
                return encoding
            }
            return JSONEncoding.prettyPrinted
        }()
        
        alamofireManager?.request(url,
                                  method: api.method,
                                  parameters: parameters,
                                  encoding: finalEncoding,
                                  headers: finalHeaders)
        .cURLDescription(calling: { (curl) in
            print(curl)
        })
        .responseJSON(completionHandler: { (response) in
            print("---------------------------------")
            let statusCode = response.response?.statusCode
            switch statusCode {
            case 200 :
                completion?(true, false, nil)
            case 400 :
                switch response.result{
                case .success(let data):
                    completion?(false, false, data)
                case .failure( _):
                    completion?(false, true, nil)
                }
                
            case 401:
                break
            case 404:
                completion?(false, false, nil)
            default:
                completion?(false, true, nil)
                break
                print("Kết nối thất bại")
            }
        })
    }
    
    //MARK: Upload camera snapshot jpg image to BE
    ///
    /// - Parameters:
    ///   - api:            `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - method:         `subPathAPI` for the `api`. `nil` by default. (Exp: query?..)
    ///   - fileName:       `fileName` value file location.
    ///   - data:           `data` value of UIImage. `nil` by default.
    ///   - parameters:     `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` bydefault.
    ///   - completion:     `RequestCompletion` `RequestCompletion` by default
    ///
    /// - Returns:              `Void`.
    func uploadFileSnapshot(apiUrl: String,
                            method: HTTPMethod,
                            fileName: String,
                            data: Data,
                            parameters: [String : Any],
                            completion: RequestCompletion) {
        
        let finalHeaders: HTTPHeaders = {
            return getDefaultHeaderTypeJSON()
        }()
        
        alamofireManager?.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: "\(fileName).jpg",
                                     mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!,
                                         withName: key)
            }
        }, to: apiUrl, method: .post, headers: finalHeaders)
        .responseJSON { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200:
                    completion?(true, false, data)
                    
                case 400:
                    completion?(false, false, data)
                    
                case 401:
                    break
                case 404:
                    completion?(false, false, nil)
                default:
                    break
                    print("Kết nối thất bại")
                    completion?(false, false, nil)
                }
            case .failure( _):
                switch statusCode {
                case 401:
                    break
                default:
                    completion?(false, true, nil)
                }
            }
        }
    }
    
    //MARK: Upload jpeg image to BE
    ///
    /// - Parameters:
    ///   - api:            `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - method:         `subPathAPI` for the `api`. `nil` by default. (Exp: query?..)
    ///   - fileName:       `fileName` value file location.
    ///   - data:           `data` value of UIImage. `nil` by default.
    ///   - parameters:     `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` bydefault.
    ///   - completion:     `RequestCompletion` `RequestCompletion` by default
    ///
    /// - Returns:              `Void`.
    func uploadFile(apiUrl: String,
                    method: HTTPMethod,
                    fileName: String,
                    data: Data? = nil,
                    parameters: [String : Any],
                    completion: RequestCompletion) {
        
        let finalHeaders: HTTPHeaders = {
            return getDefaultHeaderTypeJSON()
        }()
        
        let finalData: Data = {
            if let dataInput = data {
                return dataInput
            }
            
            let image = UIImage.init(named: fileName)
            return image!.jpegData(compressionQuality: 0.7)!
        }()
        
        alamofireManager?.upload(multipartFormData: { multipartFormData in
            multipartFormData.append( finalData,
                                      withName: "file",
                                      fileName: "\(fileName).jpeg",
                                      mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: apiUrl, method: .post, headers: finalHeaders)
        .responseJSON { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200:
                    completion?(true, false, data)
                    
                case 400:
                    completion?(false, false, data)
                    
                case 401:
                    break
                case 404:
                    completion?(false, false, nil)
                default:
                    break
                    print("Kết nối thất bại")
                    completion?(false, false, nil)
                }
            case .failure( _):
                switch statusCode {
                case 401:
                    break
                case 404:
                    completion?(false, false, nil)
                default:
                    completion?(false, true, nil)
                }
            }
        }
    }
    
    
    /// Tải video về để nhận file `m3u8`
    /// - Parameters:
    ///   - url: `URL`
    ///   - completion:
    func downloadVideoCloud( identifier: String, url: String, completion: @escaping ((String?) -> Void) ) {
        self.alamofireManager?
            .request(url)
            .responseData{ (response) in
                switch response.result {
                case let .success(value):
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let videoM3u8 = documentsURL.appendingPathComponent("m3u8_\(identifier).m3u8")
                    do {
                        try value.write(to: videoM3u8)
                        completion(videoM3u8.absoluteString)
                    } catch {
                        completion(nil)
                    }
                case let .failure(error):
                    completion(nil)
                    print(error)
                }
            }
    }
}

private let arrayParametersKey = "arrayParametersKey"

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}


/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
public struct ArrayEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    
    /// Creates a new instance of the encoding using the given options
    ///
    /// - parameter options: The options used to encode the json. Default is `[]`
    ///
    /// - returns: The new instance
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
              let array = parameters[arrayParametersKey] else {
            return urlRequest
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
