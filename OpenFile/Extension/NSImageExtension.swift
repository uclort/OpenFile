//
//  NSImageExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension NSImage {
    func toPng() -> Data? {
        guard let tiffData = self.tiffRepresentation else {
            return nil
        }
        let imageRep = NSBitmapImageRep(data: tiffData)
        imageRep?.size = size
        guard let imageData = imageRep?.representation(using: .png, properties: [.compressionFactor: 0.5]) else {
            return nil
        }
        return imageData
    }
    //  Converted to Swift 5.1 by Swiftify v5.1.17924 - https://objectivec2swift.com/
//    func image(byApplyingAlpha alpha: CGFloat) -> NSImage? {
//        
//        UIGraphicsBeginImageContextWithOptions(size, _: false, _: 0.0)
//        
//        let ctx = UIGraphicsGetCurrentContext()
//        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//
//        ctx?.scaleBy(x: 1, y: -1)
//        ctx?.translateBy(x: 0, y: -area.size.height)
//
//        if let ctx = ctx {
//            ctx.setBlendMode(.multiply)
//        }
//
//        ctx?.setAlpha(alpha)
//
//        ctx?.draw(in: cgImage, image: area)
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }

}
