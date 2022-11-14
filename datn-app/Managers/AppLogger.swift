//
//  AppLogger.swift
//  OneHome
//
//  Created by Trung Thanh Phan on 6/17/21.
//  Copyright © 2021 VNPT - Technology. All rights reserved.
//

import Foundation
import os

enum ANSIColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case none = "\u{001B}[0;0m"
    
    func name() -> String {
        switch self {
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        case .none: return "none"
        }
    }
    
    static func all() -> [ANSIColors] {
        return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white]
    }
    
    static func levelToANSI(level: OSLogType) -> String {
        switch level {
        case OSLogType.info: return self.green.rawValue
        case OSLogType.error: return self.red.rawValue
        case OSLogType.debug: return self.yellow.rawValue
        default: return self.none.rawValue
        }
    }
    
    static func levelToANSIConsole(level: OSLogType) -> String {
        switch level {
        case OSLogType.info:  return "🟢 "
        case OSLogType.error: return "🔴 "
        case OSLogType.debug: return "🟡 "
        default: return self.none.rawValue
        }
    }
}


class AppLogger {
    private var _logLevel: OSLogType
    /// Get or set the log level configured for this `AppLogger`.
    @inlinable
    public var logLevel: UInt8 {
        get {
            return _logLevel.rawValue
        }
        set {
            switch newValue {
            case 1: self._logLevel = OSLogType.info
            case 2: self._logLevel = OSLogType.debug
            case 3: self._logLevel = OSLogType.error
            // case 4: self._logLevel = OSLogType.fault
            default: self._logLevel = OSLogType.default
            }
        }
    }
    private let label: String
    
    /// Factory that makes a `StreamLogHandler` to directs its output to `stdin`
    public static func stdioAppLogger(label: String) -> AppLogger {
        return AppLogger(label: label)
    }
    
    public static let shared = AppLogger(label: "Global")
    
    
    internal init(label: String) {
        self.label = label
        self._logLevel = OSLogType.default
    }
    
    #if compiler(>=5.3)
    @inlinable
    public func log(level: OSLogType,
                    message: String,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) {
        if self._logLevel.rawValue < level.rawValue {
            print(ANSIColors.levelToANSIConsole(level: level) + "\(self.timestamp()) \(level.rawValue) \(self.label) \(file) : [\(function) line: \(line)] \(message)\n")
        }
        
    }
    #else
    @inlinable
    public func log(level: OSLogType,
                    message: String,
                    file: String = #file,
                    function: String = #function,
                    line: UInt = #line) {
        if self._logLevel.rawValue < level.rawValue {
            if self._logLevel.rawValue < level.rawValue {
                //                print(ANSIColors.levelToANSI(level: level) + "\(self.timestamp()) \(level) \(self.label) \(file) : [\(function) line: \(line)] \(message)\n" + ANSIColors.none.rawValue)
                
                print(ANSIColors.levelToANSI(level: level) + "\(self.timestamp()) \(level.rawValue) \(self.label) \(file) : [\(function) line: \(line)] \(message)\n")
            }
        }
        
    }
    #endif
    
    /// Logging with info level
    #if compiler(>=5.3)
    @inlinable
    public func info(message: String,
                     file: String = #fileID,
                     function: String = #function,
                     line: UInt = #line) {
        self.log(level: OSLogType.info, message: message, file: file, function: function, line: line)
    }
    #else
    @inlinable
    public func info(message: String,
                     file: String = #file,
                     function: String = #function,
                     line: UInt = #line) {
        self.log(level: OSLogType.info, message: message, file: file, function: function, line: line)
    }
    #endif
    
    /// From swift open source logging API
    private func timestamp() -> String {
        var buffer = [Int8](repeating: 0, count: 255)
        #if os(Windows)
        var timestamp: __time64_t = __time64_t()
        _ = _time64(&timestamp)
        
        var localTime: tm = tm()
        _ = _localtime64_s(&localTime, &timestamp)
        
        _ = strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", &localTime)
        #else
        var timestamp = time(nil)
        let localTime = localtime(&timestamp)
        strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", localTime)
        #endif
        return buffer.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: CChar.self) {
                String(cString: $0.baseAddress!)
            }
        }
    }
    
    /// Logging with error level
    #if compiler(>=5.3)
    @inlinable
    public func error(message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: UInt = #line) {
        self.log(level: OSLogType.error, message: message, file: file, function: function, line: line)
    }
    #else
    @inlinable
    public func error(message: String,
                      file: String = #file,
                      function: String = #function,
                      line: UInt = #line) {
        self.log(level: OSLogType.error, message: message, file: file, function: function, line: line)
    }
    #endif
    
    /// Logging with debug level
    #if compiler(>=5.3)
    @inlinable
    public func debug(message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: UInt = #line) {
        self.log(level: OSLogType.debug, message: message, file: file, function: function, line: line)
    }
    #else
    @inlinable
    public func debug(message: String,
                      file: String = #file,
                      function: String = #function,
                      line: UInt = #line) {
        self.log(level: OSLogType.debug, message: message, file: file, function: function, line: line)
    }
    #endif
}
