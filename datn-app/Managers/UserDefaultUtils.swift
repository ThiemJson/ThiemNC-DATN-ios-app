//
//  UserDefaultUtils.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 7/9/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case authExpires = "authExpires-key"
    case authRefreshToken = "authRefreshToken-key"
    case authScope = "authScope-key"
    case authTokenType = "authTokenType-key"
    case authAccessToken = "authAccessToken-key"
    case currentHome = "currentHome"
    case justDownloadTheApp = "justDownloadTheApp"
    case appCurrentLanguage = "appCurrentLanguage"
    case userAvatarPath = "userAvatarPath"
    case currentUserId = "currentUserId"
    case registeredDevices = "registeredDevices"
    case hotLineNameArray = "hotLineNameArray"
    case hotLinePhoneArray = "hotLinePhoneArray"
    case fcmToken = "fcmToken"
    case cameraUid = "cameraUid"
    case notiStatus = "notiStatus"
    case isFromBackground = "isFromBackground"
    case screenFlag = "screenFlag"
    case timeSunset = "timeSunset"
    case timeSunrise = "timeSunrise"
    case sharing = "sharing"
    case shareType = "shareType"
    case cameraGalleryMode = "cameraGalleryMode"
    /// `Tăng trải nghiệm`
    case localAuth = "localAuth"
    case previousUsername = "previousUsername"
}

class UserDefaultUtils {

    static let shared = UserDefaultUtils()

    private var userDefault: UserDefaults = UserDefaults.standard

    func save<T>(key: UserDefaultsKey, value: T) {
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }

    func save<T>(key: String, value: T) {
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    func get(key: UserDefaultsKey) -> Any? {
        return userDefault.value(forKey: key.rawValue)
    }

    func get(key: String) -> Any? {
        return userDefault.value(forKey: key)
    }
    
    func delete(key: UserDefaultsKey) {
       if self.userDefault.value(forKey: key.rawValue) != nil {
           self.userDefault.removeObject(forKey: key.rawValue)
       }
    }

    func delete(key: String) {
       if self.userDefault.value(forKey: key) != nil {
           self.userDefault.removeObject(forKey: key)
       }
    }
    
    func isValiAccessToken() -> Bool {
        guard let expired = get(key: .authExpires) as? Double else {
            return false
        }
        let dateFromExpired = Date(timeInterval: expired, since: Date(timeIntervalSince1970: expired))
        return fabs(dateFromExpired.timeIntervalSinceNow) > 86400
    }

    func getAccessTokenWithValidate() -> String? {
        guard let tokenType = getTokenType() else {
            return nil
        }

        guard let accessToken = getAccessToken() else {
            return nil
        }

        return "\(tokenType) \(accessToken)"
    }

    func getExpriesIn() -> TimeInterval? {
        return get(key: .authExpires) as? TimeInterval
    }

    func getRefreshToken() -> String? {
        return get(key: .authRefreshToken) as? String
    }

    func getScope() -> String? {
        return get(key: .authScope) as? String
    }

    func getTokenType() -> String? {
        return get(key: .authTokenType) as? String
    }

    func saveAccessToken(token: String) {
        save(key: .authAccessToken, value: token)
    }

    func getAccessToken() -> String? {
        return get(key: .authAccessToken) as? String
    }

    func removeAccessToken() {
        delete(key: .authAccessToken)
    }
    
    func saveCurrentUserId(_ userId: Int) {
        save(key: .currentUserId, value: userId)
    }
    
    func getCurrentUserId() -> Int {
        return get(key: .currentUserId) as? Int ?? 0
    }
    
    func generateKeyCurrentHomeId() -> String {
        return "\(UserDefaultsKey.currentHome)_\(getCurrentUserId())"
    }
    
    func saveCurrentHome(idHome: Int) {
        save(key: generateKeyCurrentHomeId(), value: idHome)
    }
    
    func getCurrentHomeId() -> Int {
        return get(key: generateKeyCurrentHomeId()) as? Int ?? 0
    }
    
    func removeCurrentHome() {
        delete(key: generateKeyCurrentHomeId())
    }
    
    func saveAppLanguage(language: String) {
        save(key: .appCurrentLanguage, value: language)
    }
    func getAppLanguage() -> String? {
        return get(key: .appCurrentLanguage) as? String
    }
    
    func getUserUsageStatus() -> Bool {
        return get(key: .justDownloadTheApp) as? Bool ?? true
    }
    func saveUserUsageStatus(Status: Bool) {
        save(key: .justDownloadTheApp, value: Status)
    }
    
    func getUserAvatarPath() -> String {
        return get(key: .userAvatarPath) as? String ?? ""
    }
    func saveUserAvatarPath(path: String){
        save(key: .userAvatarPath, value: path)
    }
    
    func generateKeyRegisteredDevice() -> String {
        return "\(UserDefaultsKey.registeredDevices)_\(getCurrentUserId())_\(getCurrentHomeId())"
    }
    
    func saveStateRegisteredDevice(_ state: Bool = true) {
        save(key: generateKeyRegisteredDevice(), value: state)
    }
    
    func getStateRegisteredDevice() -> Bool {
        return get(key: generateKeyRegisteredDevice()) as? Bool ?? false
    }
    
    func saveHotLineNameArray(_ names: Array<String> = []) {
        save(key: .hotLineNameArray, value: names)
    }
    
    func getHotLineNameArray() -> Array<String> {
        return get(key: .hotLineNameArray) as? Array<String> ?? []
    }
    
    func saveHotLinePhoneArray(_ names: Array<String> = []) {
        save(key: .hotLinePhoneArray, value: names)
    }
    
    func getHotLinePhoneArray() -> Array<String> {
        return get(key: .hotLinePhoneArray) as? Array<String> ?? []
    }
    
    func saveFcmToken(fcmToken: String) {
        save(key: .fcmToken, value: fcmToken)
    }
    func getFcmToken() -> String? {
        return get(key: .fcmToken) as? String
    }
    
    func getUserCameraUid() -> String {
        return get(key: .cameraUid) as? String ?? ""
    }
    func saveUserCameraUid(path: String){
        save(key: .cameraUid, value: path)
    }
    
    func saveNotiStatus(status: Bool) {
        save(key: .notiStatus, value: status)
    }
    
    func getNotiStatus() -> Bool {
        return get(key: .notiStatus) as? Bool ?? true
    }
    
    func saveAppStates(path: Bool){
        save(key: .isFromBackground, value: path)
    }
    
    func getAppStates() -> Bool {
        return get(key: .isFromBackground) as? Bool ?? false
    }
    
    func saveScreenFlag(flagId: Int) {
        save(key: .screenFlag, value: flagId)
    }
    
    func getScreenFlag() -> Int {
        return get(key: .screenFlag) as? Int ?? 0
    }
    
    func saveAttemptLogin(userName: String, time: Int64) {
        save(key: userName + "login", value: time)
    }
    
    func getAttemptLogin(userName: String) -> Int64 {
        return get(key: userName + "login") as? Int64 ?? 0
    }
    
    func saveAttemptSendOtp(userName: String, time: Int64) {
        save(key: userName + "sendOtp", value: time)
    }
    
    func getAttemptSendOtp(userName: String) -> Int64 {
        return get(key: userName + "sendOtp") as? Int64 ?? 0
    }
    
    func saveAttemptEnterOtp(userName: String, time: Int64) {
        save(key: userName + "enterOtp", value: time)
    }
    
    func getAttemptEnterOtp(userName: String) -> Int64 {
        return get(key: userName + "enterOtp") as? Int64 ?? 0
    }
    
    func saveAttemptDevice(uid: String, time: Int64) {
        save(key: uid + "deviceTime", value: time)
    }
    
    func getAttemptDevice(uid: String) -> Int64 {
        return get(key: uid + "deviceTime") as? Int64 ?? 0
    }
    
    func saveAttemptDeviceLimit(uid: String, count: Int) {
        save(key: uid + "deviceLimit", value: count)
    }
    
    func getAttemptDeviceLimit(uid: String) -> Int {
        return get(key: uid + "deviceLimit") as? Int ?? 0
    }
    
    func saveAttemptDeviceProcess(uid: String, count: CFloat) {
        save(key: uid + "process", value: count)
    }
    
    func getAttemptDeviceProcess(uid: String) -> CFloat {
        return get(key: uid + "process") as? CFloat ?? 0
    }
    
    func saveDeviceAutoUpdate(uid: String, isAuto: Bool) {
        save(key: uid + "autoUpdate", value: isAuto)
    }
    
    func getDeviceAutoUpdate(uid: String) -> Bool {
        return get(key: uid + "autoUpdate") as? Bool ?? false
    }
    
    func getTimeSunset() -> String? {
        return get(key: .timeSunset) as? String
    }
    func saveTimeSunset(path: String){
        save(key: .timeSunset, value: path)
    }
    
    func getTimeSunrise() -> String? {
        return get(key: .timeSunrise) as? String
    }
    func saveTimeSunrise(path: String){
        save(key: .timeSunrise, value: path)
    }
    
    func getSharing() -> Bool {
        return get(key: .sharing) as? Bool ?? false
    }
    func saveSharing(value: Bool) {
        save(key: .sharing, value: value)
    }
    
    func getShareType() -> Int {
        return get(key: .shareType) as? Int ?? 1
    }
    func saveShareType(value: Int) {
        save(key: .shareType, value: value)
    }
    
    func saveDevicePolicyLimit(uid: String, policyId:Int, status: Int) {
        save(key: "\(uid)_\(policyId)", value: status)
    }
    
    func getDevicePolicyLimit(uid: String, policyId:Int) -> Int {
        return get(key: "\(uid)_\(policyId)") as? Int ?? 0
    }
    
    func savePasswordWifi(ssid: String, password: String) {
        save(key: ssid, value: password)
    }
    
    func getPasswordWifi(ssid: String) -> String {
        return get(key: ssid) as? String ?? ""
    }
    //MARK: CR03 - If current Home shared by other user -> return true -> Limited access
    func homeLimitedAccessPermission() -> Bool {
      return getSharing()
    }
    
    // MARK: Camera3.0 - Cần lưu lại trạng thái 1,4,9 của camera gallery
    func getCameraGalleryMode() -> Int {
        return get(key: .cameraGalleryMode) as? Int ?? 0
    }
    
    func setCameraGalleryMode(value: Int) {
        save(key: .cameraGalleryMode, value: value)
    }
    
    func getPreviousUsername() -> String {
        return get(key: .previousUsername) as? String ?? ""
    }
    
    func setPreviousUsername(value: String) {
        save(key: .previousUsername, value: value)
    }
    
    func getAccountPassword(userName: String) -> String {
        return get(key: userName) as? String ?? ""
    }
    
    func setAccountPassword( userName: String, password: String) {
        save(key: userName, value: password)
    }
}
