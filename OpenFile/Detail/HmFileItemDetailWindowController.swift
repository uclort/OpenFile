//
//  CustomNicknameWindowController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/26.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmFileItemDetailWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func setItemDataDetail(model: HmMainFileModel, index: Int) {
        guard let contentController = window?.contentViewController as? HmFileItemDetailContentViewController else {
            return
        }
        contentController.setItemDataDetail(model: model, index: index)
    }

}
