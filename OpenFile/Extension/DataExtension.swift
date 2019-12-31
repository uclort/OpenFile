//
//  DataExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

//extension Data {
//    
//    func pngCompress(_ maximum:Int = 100) -> Data? {
//        return data2Data(self, maximum)
//    }
//    
//    /// 通过PNG图片Data压缩
//    ///
//    /// - Parameters:
//    ///   - data: PNG图片Data
//    ///   - maximum: 压缩率，0-100,100为最好
//    /// - Returns: 压缩后的PNG图片Data
//    func data2Data(_ data:Data,_ maximum:Int) -> Data?{
//        var mini:UnsafeMutablePointer<UInt8>? = UnsafeMutablePointer.allocate(capacity: 0)
//        let pngData:UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.allocate(capacity: data.count)
//        data.copyBytes(to: pngData, count: data.count)
//        let count:Int = Int(_data2Data(&mini,Int32(maximum),pngData,data.count))
//        if count == 0 {
//            return nil;
//        }
//        let result =  Data(bytes: mini!, count: count);
//        mini?.deinitialize(count: count)
//        mini?.deallocate()
//        return result;
//    }
//}
