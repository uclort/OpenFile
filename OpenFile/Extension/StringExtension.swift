//
//  StringExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/23.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension String {
    /// 从开始截取字符串
    func prefixCustom(_ maxLength: Int) -> String {
        if maxLength > count {
            return String(prefix(count))
        }
        return String(prefix(maxLength))
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    func getFileInfo() -> [String: Any?] {
        let fileURL = URL(fileURLWithPath: self)
        let workspace = NSWorkspace.shared
        var appName: NSString? = nil
        var fileType: NSString? = nil
        
        workspace.getInfoForFile(fileURL.path, application: &appName, type: &fileType)
        
        var removable: ObjCBool = false
        var writeable: ObjCBool = false
        var unmountable: ObjCBool = false
        var description: NSString? = nil
        var fileSystemType: NSString? = nil
        
        workspace.getFileSystemInfo(forPath: fileURL.path,
                                    isRemovable: &removable,
                                    isWritable: &writeable,
                                    isUnmountable: &unmountable,
                                    description: &description,
                                    type: &fileSystemType)
        
        let fileInfo: [String: Any?] = ["appName": appName,
                                        "type": fileType,
                                        "removeable": removable,
                                        "writeable": writeable,
                                        "unmountable": unmountable,
                                        "description": description,
                                        "fileSystemType": fileSystemType]
        return fileInfo
    }
}
