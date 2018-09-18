//
//  ViewController.swift
//  cryptography
//
//  Created by Vladislav Kondrashkov on 9/7/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import Cocoa

extension Int {
    // Euclidian equation for Greatest Common Divisor
    static func gcd(_ firstNumber: Int, with secondNumber: Int) -> Int {
        var buffer: Int = 0
        var x = firstNumber
        var y = secondNumber
        while y != 0 {
            buffer = y
            y = x % y
            x = buffer
        }
        return x
    }
    
    static func isMutuallyPrimal(_ firstNumber: Int, and secondNumber: Int) -> Bool {
        if Int.gcd(firstNumber, with: secondNumber) == 1 {
            return true
        }
        return false
    }
}


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
    
    let punctuationMarks = [",", ".", " ", "!", "?", ":", ";"]
    
    @IBAction func encodeButtonAction(_ sender: NSButton) {
        let sourceText = encodingSourceTextField.stringValue
        guard sourceText.isEmpty == false,
            let firstKey = Int(encodingFirstKeyField.stringValue),
            let secondKey = Int(encodingSecondKeyField.stringValue),
            let module = Int(encodingModuleField.stringValue),
            module == 26 || module == 33,
            Int.isMutuallyPrimal(firstKey, and: module) == true,
            Int.isMutuallyPrimal(secondKey, and: module) == true else {
                return
        }
        
        let encodedText = Encoder.encodeText(sourceText, with: firstKey, and: secondKey, by: module)
        encodingEncodedTextField.stringValue = encodedText
    }
    
    
    @IBAction func decodeButtonAction(_ sender: NSButton) {
        let encodedText = decodingEncodedTextField.stringValue
        guard encodedText.isEmpty == false,
            let firstKey = Int(decodingFirstKeyField.stringValue),
            let secondKey = Int(decodingSecondKeyField.stringValue),
            let module = Int(decodingModuleField.stringValue),
            module == 26 || module == 33,
            Int.isMutuallyPrimal(firstKey, and: module) == true,
            Int.isMutuallyPrimal(secondKey, and: module) == true else {
                return
        }
        
        let decodedText = Encoder.decodeText(encodedText, with: firstKey, and: secondKey, by: module)
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

