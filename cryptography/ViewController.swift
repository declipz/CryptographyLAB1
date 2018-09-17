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
    
    let punctuationMarks = [",", ".", " ", "!", "?", ":", ";"]
    
    @IBAction func encodeButtonAction(_ sender: NSButton) {
        let sourceText = encodingSourceTextField.stringValue
        let firstKey = Int(encodingFirstKeyField.stringValue)!
        let secondKey = Int(encodingSecondKeyField.stringValue)!
        let module = Int(encodingModuleField.stringValue)!
        let encodedText = encodeText(sourceText, firstKey, secondKey, module)
        
        encodingEncodedTextField.stringValue = encodedText
    
    }
    
    
    @IBAction func decodeButtonAction(_ sender: NSButton) {
        let encodedText = decodingEncodedTextField.stringValue
        let firstKey = Int(decodingFirstKeyField.stringValue)!
        let secondKey = Int(decodingSecondKeyField.stringValue)!
        let module = Int(decodingModuleField.stringValue)!
        let decodedText = decodeText(encodedText, firstKey, secondKey, module)
        
        decodingSourceTextField.stringValue = decodedText
    }
    
    func isPrimal(_ key: Int,_ module: Int) -> Bool{
        var counter = 0
        for i in 0...module {
            if i != 0 {
                if key % i == 0 && module % i == 0 {
                    counter += 1;
                }
            }
        }
        if counter == 1 {
            return true
        }
        else {
            return false
        }
    }

    
    func decodeText(_ encodedText: String,_ firstKey: Int,_ secondKey: Int,_ module: Int) -> String {
        var decodedText: String = ""
        for symbol in encodedText {
            var wholePart = 0
            if punctuationMarks.contains(String(symbol)) {
                decodedText += String(symbol)
            }
            else {
                var makingCalculations = true
                while makingCalculations {
                    switch module {
                    case 33:
                        let index = symbol.code - 1040
                        
                        let decodedIndex = module * wholePart + index - firstKey
                        if decodedIndex >= 0 {
                            if decodedIndex % secondKey == 0 {
                                let decodedSymbolCode = Int(decodedIndex / secondKey) + 1040
                                let decodedSymbol = Character(UnicodeScalar(decodedSymbolCode)!)
                                decodedText += String(decodedSymbol)
                                makingCalculations = false
                                break
                            }
                            else {
                                wholePart += 1
                            }
                        }
                        else {
                            wholePart += 1
                        }
                        
                    case 26:
                        let index = symbol.code - 65
                        
                        let decodedIndex = module * wholePart + index - firstKey
                        if decodedIndex >= 0 {
                            if decodedIndex % secondKey == 0 {
                                let decodedSymbolCode = Int(decodedIndex / secondKey) + 65
                                let decodedSymbol = Character(UnicodeScalar(decodedSymbolCode)!)
                                decodedText += String(decodedSymbol)
                                makingCalculations = false
                                break
                            }
                            else {
                                wholePart += 1
                            }
                        }
                        else {
                            wholePart += 1
                        }
                    default:
                        
                        // Make an error
                        return ""
                    }
                }
            }
        }
        return decodedText
    }
    
    func encodeText(_ sourceText: String,_ firstKey: Int,_ secondKey: Int,_ module: Int) -> String {
        var encodedText: String = ""
        for symbol in sourceText {
            if punctuationMarks.contains(String(symbol)) {
                encodedText += String(symbol)
            }
            else {
                switch module {
                case 33:
                    let index = symbol.code - 1040
                    if index < 0 || index > 31 {
                        // Make an error
                    }
                    let newSymbolCode = (index * secondKey + firstKey) % module + 1040
                    let newSymbol = Character(UnicodeScalar(newSymbolCode)!)
                    encodedText += String(newSymbol)
                case 26:
                    let index = symbol.code - 65
                    if index < 0 || index > 25 {
                        // Make an error
                    }
                    let newSymbolCode = (index * secondKey + firstKey) % module + 65
                    let newSymbol = Character(UnicodeScalar(newSymbolCode)!)
                    encodedText += String(newSymbol)
                default:
                    // Make an error
                    return ""
                }
            }

        }
        return encodedText
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let encodedText = Encoder.encodeText("HELLO WORLD", with: 3, and: 5, by: 26)
        print(Encoder.decodeText(encodedText, with: 3, and: 5, by: 26))
        
        
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

