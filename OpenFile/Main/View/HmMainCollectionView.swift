//
//  HmCollectionView.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmMainCollectionView: NSCollectionView {
    
    var fileModelGroup: [HmMainFileModel] {
        UserDefaults.getFileModels()
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reloadData(filePaths: [String]) {
        UserDefaults.setFilePaths(urls: filePaths)
        var insertIndexPath: Set<IndexPath> = []
        for idx in 0...filePaths.count - 1 {
            insertIndexPath.insert(IndexPath(item: idx, section: 0))
        }
        animator().performBatchUpdates({
            insertItems(at: insertIndexPath)
        }) { (stop) in
            self.reloadData()
        }
    }
    
    func remove(indexPath: IndexPath) {
        UserDefaults.remove(index: indexPath.item)
        animator().performBatchUpdates({
            deleteItems(at: [indexPath])
        }) { (stop) in
            self.reloadData()
        }
    }
    
    func cleanAllFile() {
        reloadData()
    }
}
