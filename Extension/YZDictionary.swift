//
//  YZDictionary.swift
//  YZLibraries
//
//  Created by Vipul Patel on 14/05/20.
//

import Foundation

//MARK: - Dictionary Extension(s)
extension Dictionary {
    
    /// It will used to convert `Dictionary` to JSON String.
    public var toJSON: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    /// It will merge existing dictionary with provided dictionary.
    /// - Parameter other: A `Dictionary` type object to merge with existance dictionary.
    public mutating func merge(_ other: Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


//MARK: - NSDictionary Extension(s)
extension NSDictionary {
    
    /// It will provide `Double` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Double` type value return.
    public func getDoubleValue(forKey: String) -> Double {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.doubleValue
            }else if let string = any as? NSString {
                return string.doubleValue
            }
        }
        return 0.0
    }
    
    /// It will provide `Float` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Float` type value return.
    public func getFloatValue(forKey: String) -> Float {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.floatValue
            }else if let string = any as? NSString {
                return string.floatValue
            }
        }
        return 0.0
    }
    
    /// It will provide `UInt` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `UInt` type value return.
    public func getUIntValue(forKey: String) -> UInt {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.uintValue
            }else if let string = any as? NSString {
                return UInt(string.integerValue)
            }
        }
        return 0
    }

    /// It will provide `Int` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Int` type value return.
    public func getIntValue(forKey: String) -> Int {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.intValue
            }else if let string = any as? NSString {
                return string.integerValue
            }
        }
        return 0
    }
    
    /// It will provide `Int64` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Int64` type value return.
    public func getInt64Value(forKey: String) -> Int64 {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return Int64(number.intValue)
            }else if let string = any as? NSString {
                return Int64(string.intValue)
            }
        }
        return 0
    }
    
    /// It will provide `Int32` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Int32` type value return.
    public func getInt32Value(forKey: String) -> Int32 {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return Int32(number.intValue)
            }else if let string = any as? NSString {
                return Int32(string.intValue)
            }
        }
        return 0
    }
    
    /// It will provide `Int16` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Int16` type value return.
    public func getInt16Value(forKey: String) -> Int16 {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return Int16(number.intValue)
            }else if let string = any as? NSString {
                return Int16(string.intValue)
            }
        }
        return 0
    }
    
    /// It will provide `Int8` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Int8` type value return.
    public func getInt8Value(forKey: String) -> Int8 {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return Int8(number.intValue)
            }else if let string = any as? NSString {
                return Int8(string.intValue)
            }
        }
        return 0
    }

    /// It will provide `String` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `String` type value return.
    public func getStringValue(forKey: String) -> String {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.stringValue
            }else if let string = any as? String {
                return string
            }
        }
        return ""
    }
    
    /// It will provide `Bool` type value from given `NSDictionary`.
    /// - Parameter forKey: Key name to get value.
    /// - Returns: `Bool` type value return.
    public func getBooleanValue(forKey: String) -> Bool {
        if let any: Any = value(forKey: forKey) {
            if let number = any as? NSNumber {
                return number.boolValue
            }else if let string = any as? NSString {
                return string.boolValue
            }
        }
        return false
    }
}
