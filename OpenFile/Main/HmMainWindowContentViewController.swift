//
//  HmPopoverController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/23.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import SnapKit

var windowWidth = 500

var leftRightSpacing = 20

var itemSpacing = 10

var column = 5

var itemWidth = (windowWidth - (column - 1) * itemSpacing - leftRightSpacing * 2) / 5

extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier(NSStringFromClass(HmMainCollectionItem.self))
}

class HmMainWindowContentViewController: NSViewController {
    
    private var closeButton: NSButton!
    
    @IBOutlet weak var mainCollectionView: HmMainCollectionView!
    
    private var leftRightSpacing = 20
    
    var indexPathsOfItemsBeingDragged: Set<IndexPath> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviewCustom()
        addConstraintCustom()
        addBindSignal()
        NotificationCenter.addObserver(self, selector: #selector(updateCollectionView(notification:)), name: .QuickProjectUpdated)
        registerForDragAndDrop()
        
    }
    func registerForDragAndDrop() {
        mainCollectionView.registerForDraggedTypes([.fileURL])
        mainCollectionView.setDraggingSourceOperationMask(.every, forLocal: true)
        mainCollectionView.setDraggingSourceOperationMask(.every, forLocal: false)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.standardWindowButton(.closeButton)?.alphaValue = 0
        view.window?.standardWindowButton(.miniaturizeButton)?.alphaValue = 0
        view.window?.standardWindowButton(.zoomButton)?.alphaValue = 0
        mainCollectionView.reloadData()
    }
    
    func addSubviewCustom() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(itemSpacing)
        flowLayout.minimumInteritemSpacing = CGFloat(itemSpacing)
        flowLayout.sectionInset = NSEdgeInsets(top: CGFloat(itemSpacing), left: CGFloat(leftRightSpacing), bottom: CGFloat(itemSpacing), right: CGFloat(leftRightSpacing))
        
        mainCollectionView.collectionViewLayout = flowLayout
        mainCollectionView.backgroundColors = [NSColor.clear]
        mainCollectionView.collectionViewLayout = flowLayout
        mainCollectionView.register(HmMainCollectionItem.self, forItemWithIdentifier: .collectionViewItem)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
    }
    
    func addConstraintCustom() {
        
    }
    
    func addBindSignal() {
        
    }
    
    @objc
    func updateCollectionView(notification: NSNotification) {
        guard let indexItem = notification.object as? Int else {
            return
        }
        mainCollectionView.reloadItems(at: [IndexPath(item: indexItem, section: 0)])
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) -> deinit")
        NotificationCenter.removeObserver(self)
    }
    
    
}
extension HmMainWindowContentViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let collectionView = collectionView as? HmMainCollectionView else { return NSCollectionViewItem() }
        let item = collectionView.makeItem(withIdentifier: .collectionViewItem, for: indexPath) as! HmMainCollectionItem
        item.indexPathIndex = indexPath.item
        let filePath = mainCollectionView.fileModelGroup[indexPath.item]
        item.setFilePath(model: filePath)
        item.clickButtonHandler = {
            let fileUrl = URL(fileURLWithPath: filePath.path)
            NSWorkspace.shared.open(fileUrl)
        }
        item.removeItemHandler = {
            collectionView.remove(indexPath: indexPath)
        }
        return item
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCollectionView.fileModelGroup.count
    }
    
}

extension HmMainWindowContentViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: itemWidth, height: 100)
    }
}

extension HmMainWindowContentViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let filePath = mainCollectionView.fileModelGroup[indexPath.item]
        return filePath.pathURL as NSPasteboardWriting
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexPaths: Set<IndexPath>) {
        indexPathsOfItemsBeingDragged = indexPaths
        for indexPath in indexPaths {
            if let item = collectionView.item(at: indexPath) as? HmMainCollectionItem {
                item.fileIcon.alphaValue = 1.0
            }
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        indexPathsOfItemsBeingDragged = []
    }
    
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        if proposedDropOperation.pointee == .on {
            proposedDropOperation.pointee = .before
        }
        if indexPathsOfItemsBeingDragged.isEmpty {
            return NSDragOperation.copy
        } else {
            return NSDragOperation.move
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        if indexPathsOfItemsBeingDragged.isEmpty {
            UserDefaults.insertFilePaths(urls: draggingInfo.filePaths, insertIndex: indexPath.item)
            collectionView.animator().performBatchUpdates({
                collectionView.insertItems(at: draggingInfo.filePaths.generateIndexPaths(initialItem: indexPath.item))
            }) { (stop) in
                collectionView.reloadData()
            }
        } else {
            let indexPathOfFirstItemBeingDragged = indexPathsOfItemsBeingDragged.first!
            var toIndexPath: IndexPath
            if indexPathOfFirstItemBeingDragged.compare(indexPath) == .orderedAscending {
                toIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            } else {
                toIndexPath = IndexPath(item: indexPath.item, section: indexPath.section)
            }
            UserDefaults.moveFilePath(index: indexPathOfFirstItemBeingDragged.item, to: toIndexPath.item)
            collectionView.animator().performBatchUpdates({
                collectionView.moveItem(at: indexPathOfFirstItemBeingDragged, to: toIndexPath)
            }) { (stop) in
                collectionView.reloadData()
            }
        }
        return true
    }
}
    
    
    

