//
//  ArrayExtension.swift
//  uPic
//
//  Created by 侯猛 on 2019/12/3.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Foundation

extension Array {
    
    func forEach(_ body: (Element, Int) -> Void) {
        forEachStop { (object, idx, _) in
            body(object, idx)
        }
    }
    
    func forEachLast(_ body: (Element, Int, Bool) -> Void) {
        forEachStop { (object, idx, _) in
            let isLast = (idx == count - 1)
            body(object, idx, isLast)
        }
    }
    
    func forEachStop(_ body: (Element, Int, ((Bool) -> Void)) -> Void) {
        var idx = 0
        for item in self {
            var isStop: Bool = false
            body(item, idx, { stop in
                isStop = stop
            })
            if isStop == true {
                return
            } else {
                idx+=1
            }
        }
    }
    
    func objectForIndex(idx: Int?) -> Element? {
        guard let idx = idx else {
            return nil
        }
        guard idx <= (count - 1) else {
            return nil
        }
        return self[idx]
    }
    
    @discardableResult
    func compactMapCustom<T>(_ body: (Element, Int) -> T?) -> [T] {
        var newItemGroup: [T] = []
        forEach { (item, idx) in
            guard let newItem = body(item, idx) else {
                return
            }
            newItemGroup.append(newItem)
        }
        return newItemGroup
    }
    
    func merge<T>(newGroup: [T]) -> [T] {
        var selfGroup: [T] = self as! [T]
        newGroup.reversed().forEach { (item) in
            selfGroup.insert(item, at: 0)
        }
        return selfGroup
    }
    
    func generateIndexPaths(initialItem: Int = 0, initialSection: Int = 0) -> Set<IndexPath> {
        var indexPathSet: Set<IndexPath> = []
        forEach { (_, idx) in
            indexPathSet.insert(IndexPath(item: idx + initialItem, section: initialSection))
        }
        return indexPathSet
    }
    
}
