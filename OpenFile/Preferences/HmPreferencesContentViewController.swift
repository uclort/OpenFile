//
//  HmPreferencesContentViewController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/27.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import MASShortcut
import LoginServiceKit

class HmPreferencesContentViewController: NSViewController {

    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var showMainWindowHotKeyView: MASShortcutView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showMainWindowHotKeyView.associatedUserDefaultsKey = "showMainWindowHotKeyView"
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        refreshButtonState()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if NSApp.activationPolicy() == .accessory {
            NSApp.setActivationPolicy(.regular)
        }
    }
    
    @IBAction func startButtonClick(_ sender: NSButton) {
        if sender.state == .on {
            LoginServiceKit.addLoginItems()
        } else if sender.state == .off {
            LoginServiceKit.removeLoginItems()
        }
    }
    func refreshButtonState() {
        startButton.state = LoginServiceKit.isExistLoginItems() ? .on : .off
    }
}
