//
//  DictionaryExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    func hm_stringForKey(_ key: String) -> String? {
        let value = self[key]
        if let valueInt = value as? Int64 { // 是整型
            let number = NSNumber(value: valueInt)
            let formatter = NumberFormatter()
            return formatter.string(from: number) ?? ""
        } else if let valueDouble = value as? Double { // 是浮点型
            let number = NSNumber(value: valueDouble)
            let formatter = NumberFormatter()
            return formatter.string(from: number) ?? ""
        } else if let valueString = value as? String {
            return valueString
        } else {
            return nil
        }
    }
    
    func hm_dictionaryForKey(_ key: String) -> [String: Any] {
        let value = (self[key] as? [String: Any]) ?? [:]
        if value.isEmpty {
            return [:]
        } else {
            return value
        }
    }
    
    func hm_dataForKey(_ key: String) -> Data? {
        let value = self[key]
        if let valueData = value as? Data {
            return valueData
        }
        return nil
    }
    
    func hm_floatForKey(_ key: String) -> Double {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return Double(valueInt)
        } else if let valueFloat = value as? Double { // 是浮点型
            return valueFloat
        } else if let valueString = value as? String {
            return Double(valueString) ?? 0.0
        } else {
            return 0.0
        }
    }
    
    func hm_intForKey(_ key: String) -> Int? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt
        } else if let valueFloat = value as? Double { // 是浮点型
            return Int(valueFloat)
        } else if let valueString = value as? String {
            return Int(valueString)
        } else {
            return nil
        }
    }
    
    func hm_timeIntervalForKey(_ key: String) -> TimeInterval {
        let value = self[key]
        if let valueInt = value as? Int64 { // 是整型
            return TimeInterval(valueInt)
        } else if let valueFloat = value as? Double { // 是浮点型
            return TimeInterval(Int(valueFloat))
        } else if let valueString = value as? String {
            return TimeInterval(Int(valueString) ?? 0)
        } else {
            return TimeInterval(0)
        }
    }
    
    func toJsonString() -> String? {
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            
            print("is not a valid json object")
            
            return nil
            
        }
        
        //利用自带的json库转换成Data
        
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        
        //Data转换成String打印输出
        
        let str = String(data:data!, encoding: String.Encoding.utf8)
        
        //输出json字符串
        
        
        return str
        
    }
    
    func merge(_ otherDictionary: [String: Any]?) -> [String: Any] {
        guard let otherDictionary = otherDictionary else {
            return self
        }
        var newDictionary: [String: Any] = [:]
        for item in self {
            newDictionary[item.key] = item.value
        }
        for item in otherDictionary {
            newDictionary[item.key] = item.value
        }
        return newDictionary
    }
}
