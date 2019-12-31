//
//  NotificationCenterExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension NSNotification.Name {
    /// 快捷项目已更新
    static let QuickProjectUpdated = NSNotification.Name("QuickProjectUpdated")
}

extension NotificationCenter {
    
    class func post(name: NSNotification.Name, object: Any? = nil) {
        self.default.post(name: name, object: object)
    }
    
    class func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any? = nil) {
        self.default.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }
    
    class func removeObserver(_ observer: Any) {
        self.default.removeObserver(self)
    }
    
    class func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any? = nil) {
        self.default.removeObserver(observer, name: aName, object: anObject)
    }
    
}

