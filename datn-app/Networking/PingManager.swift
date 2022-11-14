//
//  PingManager.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 15/04/2021.
//  Copyright © 2021 VNPT Technology. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class PingManager {
    static let shared = PingManager()
    var alamofireManager: Session?
    var isCooldown = false
    fileprivate let networkTimeout: TimeInterval = 5
    static let isConnect: PublishSubject<Bool> = PublishSubject()

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkTimeout
        configuration.timeoutIntervalForResource = networkTimeout
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        alamofireManager = Session(configuration: configuration)
    }
    
    func checkInternetConnection(completionHandler: @escaping (_ isReachable:Bool) -> Void) {
        self.alamofireManager?.request("https://google.com").response { response in
            completionHandler(response.response?.statusCode == 200)
            PingManager.isConnect.onNext(response.response?.statusCode == 200)
        }
    }
}
