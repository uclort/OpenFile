//
//  UserDefaultsExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension UserDefaults {
    
    class func setFilePaths(urls: [String]) {
        var newUrls = urls.compactMapCustom { (path, idx) -> [String: Any?]? in
            var filePathsInfo: [String: Any?] = [:]
            filePathsInfo["path"] = path
            return filePathsInfo
        }
        newUrls = getFilePathsInfo().merge(newGroup: newUrls)
        standard.setValue(newUrls, forKey: "fileUrlGroup")
        standard.synchronize()
    }
    
    class func insertFilePaths(urls: [String], insertIndex: Int) {
        var oldFileInfos = getFilePathsInfo()
        urls.forEach { (path, idx) in
            oldFileInfos.insert(["path": path], at: idx + insertIndex)
        }
        standard.setValue(oldFileInfos, forKey: "fileUrlGroup")
        standard.synchronize()
    }
    
    class func moveFilePath(index: Int, to Index: Int) {
        var fileInfos = getFilePathsInfo()
        let item = fileInfos[index]
        fileInfos.remove(at: index)
        fileInfos.insert(item, at: Index)
        standard.setValue(fileInfos, forKey: "fileUrlGroup")
        standard.synchronize()
    }
    
    class func getFilePathsInfo() -> [[String: Any?]] {
        guard let urls = standard.object(forKey: "fileUrlGroup") as? [[String: Any]] else {
            return []
        }
        return urls
    }
    
    class func getFileModels() -> [HmMainFileModel] {
        let models: [HmMainFileModel] = getFilePathsInfo().compactMapCustom({ (info, idx) -> HmMainFileModel? in
            return HmMainFileModel(path: info.hm_stringForKey("path") ?? "", customNickname: info.hm_stringForKey("customNickname"))
        })
        return models
    }
    
    class func changeFilePathInfo(index: Int, customNickname: String) {
        var filePaths = getFilePathsInfo()
        guard var filePathInfo = filePaths.objectForIndex(idx: index) else {
            return
        }
        filePathInfo["customNickname"] = customNickname
        filePaths[index] = filePathInfo
        standard.setValue(filePaths, forKey: "fileUrlGroup")
        standard.synchronize()
    }
    
    class func remove(index: Int) {
        var urls = getFilePathsInfo()
        if index < urls.count {
            urls.remove(at: index)
        }
        standard.setValue(urls, forKey: "fileUrlGroup")
        standard.synchronize()
    }
    
    class func cleanFilePaths() {
        standard.setValue([], forKey: "fileUrlGroup")
        standard.synchronize()
    }
}
