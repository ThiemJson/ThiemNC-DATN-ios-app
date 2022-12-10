//
//  CoreLocationService.swift
//  datn-app
//
//  Created by vnpt on 08/12/2022.
//  Copyright © 2022 VNPT Technology. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class CoreLocationService : NSObject {
    static let shared           =  CoreLocationService()
    let locationManager         = CLLocationManager()
    let rxCLLocation            = BehaviorRelay<CLLocation?>(value: nil)
    let rxError                 = BehaviorRelay<Error?>(value: nil)
    
    private override init(){
        super.init()
        self.locationManager.delegate       = self
    }
    
    func requestAlwaysAuth() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        self.locationManager.requestLocation()
    }
    
    func startScanningLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopScanningLocation() {
        self.locationManager.stopUpdatingLocation()
    }
}

extension CoreLocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(" CORE-Location status: \(status)")
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print(" CORE-Location location: \(location)")
            print(" CORE-Location latitude: \(latitude) | longitude \(longitude)")
            self.rxCLLocation.accept(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(" CORE-Location error: \(error)")
        self.rxError.accept(error)
    }
}
