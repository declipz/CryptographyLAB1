//
//  ViewController.swift
//  cryptography
//
//  Created by Vladislav Kondrashkov on 9/7/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // Encoding fields
    @IBOutlet weak var encodingSourceTextField: NSTextField!
    @IBOutlet weak var encodingFirstKeyField: NSTextField!
    @IBOutlet weak var encodingSecondKeyField: NSTextField!
    @IBOutlet weak var encodingModuleField: NSTextField!
    @IBOutlet weak var encodingEncodedTextField: NSTextField!
    
    // Decoding fields
    @IBOutlet weak var decodingEncodedTextField: NSTextField!
    @IBOutlet weak var decodingFirstKeyField: NSTextField!
    @IBOutlet weak var decodingSecondKeyField: NSTextField!
    @IBOutlet weak var decodingModuleField: NSTextField!
    @IBOutlet weak var decodingSourceTextField: NSTextField!
    
    let encoder = Encoder()
    
    @IBAction func encodeButtonAction(_ sender: NSButton) {
        encodingEncodedTextField.stringValue = ""
        
        let sourceText = encodingSourceTextField.stringValue
        guard sourceText.isEmpty == false,
            let firstKey = Int(encodingFirstKeyField.stringValue),
            let secondKey = Int(encodingSecondKeyField.stringValue),
            let module = Int(encodingModuleField.stringValue),
            module == 26 || module == 33,
            firstKey < module && secondKey < module else {
                return
        }
        
        let dialogWindow = DialogWindow(question: "Continue?", text: "One of your keys are not mutually primal with module. Result may be incorrect. Do you want to continue?")
        if !Int.isMutuallyPrimal(firstKey, and: module) || !Int.isMutuallyPrimal(secondKey, and: module) {
            if dialogWindow.ask() == false {
                return
            }
        }
        
        let encodedText = encoder.encodeText(sourceText, with: firstKey, and: secondKey, by: module)
        encodingEncodedTextField.stringValue = encodedText
    }
    
    
    @IBAction func decodeButtonAction(_ sender: NSButton) {
        decodingSourceTextField.stringValue = ""
        
        let encodedText = decodingEncodedTextField.stringValue
        guard encodedText.isEmpty == false,
            let firstKey = Int(decodingFirstKeyField.stringValue),
            let secondKey = Int(decodingSecondKeyField.stringValue),
            let module = Int(decodingModuleField.stringValue),
            module == 26 || module == 33,
            firstKey < module && secondKey < module else {
                return
        }
        
        let dialogWindow = DialogWindow(question: "Continue?", text: "One of your keys are not mutually primal with module. Result may be incorrect. Do you want to continue?")
        if !Int.isMutuallyPrimal(firstKey, and: module) || !Int.isMutuallyPrimal(secondKey, and: module) {
            if dialogWindow.ask() == false {
                return
            }
        }
        
        let decodedText = encoder.decodeText(encodedText, with: firstKey, and: secondKey, by: module)
        decodingSourceTextField.stringValue = decodedText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

