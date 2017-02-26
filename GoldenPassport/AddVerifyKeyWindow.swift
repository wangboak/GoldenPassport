//
//  AddVerifyKeyController.swift
//  GoldenPassport
//
//  Created by StanZhai on 2017/2/25.
//  Copyright © 2017年 StanZhai. All rights reserved.
//

import Cocoa
import CoreImage

class AddVerifyKeyWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var otpTextField: NSTextField!
    @IBOutlet weak var tagTextField: NSTextField!
    
    override var windowNibName : String! {
        return "AddVerifyKeyWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
    }
    
    func clearTextField() {
        otpTextField.stringValue = ""
        tagTextField.stringValue = ""
    }
    
    @IBAction func selectPicClicked(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = NSImage.imageTypes()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        
        let i = openPanel.runModal()
        if i == NSModalResponseCancel {
            return
        }
        
        let ciImage = CIImage(contentsOf: openPanel.url!)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        let results = detector?.features(in: ciImage!)
        if (results?.count)! > 0 {
            let qrFeature = results?.last as! CIQRCodeFeature
            let data = qrFeature.messageString
            otpTextField.stringValue = data!
        }
    }

    @IBAction func okBtnClicked(_ sender: NSButton) {
        
    }
    
    @IBAction func cancelBtnClicked(_ sender: NSButton) {
        self.window?.close()
    }
}
