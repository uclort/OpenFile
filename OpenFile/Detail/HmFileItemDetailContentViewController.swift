//
//  CustomNicknameController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmFileItemDetailContentViewController: NSViewController {
    @IBOutlet weak var originalName: NSTextField!
    
    @IBOutlet weak var customName: NSTextField!
    
    @IBOutlet weak var filePath: NSTextField!
    
    @IBOutlet weak var icon: NSImageView!
    
    @IBOutlet weak var confirmButton: NSButton!
    
    private var indexItem: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    func setItemDataDetail(model: HmMainFileModel, index: Int) {
        indexItem = index
        originalName.stringValue = model.name
        filePath.stringValue = model.path
        icon.image = NSWorkspace.shared.icon(forFile: model.path)
        if let customNickname = model.customNickname {
            customName.stringValue = customNickname
        }
    }
    
    @IBAction func clickSaveButton(_ sender: NSButton) {
        view.window?.close()
        UserDefaults.changeFilePathInfo(index: indexItem, customNickname: customName.stringValue)
        NotificationCenter.post(name: .QuickProjectUpdated, object: indexItem)
    }
}
