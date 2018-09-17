//
//  Encoder.swift
//  cryptography
//
//  Created by Vladislav Kondrashkov on 9/17/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

extension Character {
    var code: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

extension Int {
    // Euclidian equation for Greatest Common Divisor
    static func gcd(_ firstNumber: Int, with secondNumber: Int) -> Int {
        var buffer: Int = 0
        var x = firstNumber
        var y = secondNumber
        while secondNumber != 0 {
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

class Encoder {
    static let punctuationMarks = [",", ".", " ", "!", "?", ":", ";"]
    
    static func encodeText(_ sourceText: String, with firstKey: Int, and secondKey: Int, by module: Int) -> String {
        var indexOffset: Int = 0;
        var maxIndexLimit: Int = 0;
        
        if module == 26 {
            indexOffset = 65
            maxIndexLimit = 25
        }
        else if module == 33 {
            indexOffset = 1040
            maxIndexLimit = 31
        }
        else {
            // Make an error
            //throw ""
        }
        
        var encodedText: String = ""
        for symbol in sourceText {
            if punctuationMarks.contains(String(symbol)) {
                encodedText += String(symbol)
                continue
            }
            let characterIndex = symbol.code - indexOffset
            if characterIndex < 0 || characterIndex > maxIndexLimit {
                // Make an error
            }
            let newSymbolCode = (characterIndex * secondKey + firstKey) % module + indexOffset
            let newSymbol = Character(UnicodeScalar(newSymbolCode)!)
            encodedText += String(newSymbol)
        }
        
        return encodedText
    }
    
    static func decodeText(_ encodedText: String, with firstKey: Int, and secondKey: Int, by module: Int) -> String {
        var indexOffset: Int = 0;
        
        if module == 26 {
            indexOffset = 65
        }
        else if module == 33 {
            indexOffset = 1040
        }
        else {
            // make an error
        }
        
        var decodedText: String = ""
        for symbol in encodedText {
            var wholePart = 0
            if punctuationMarks.contains(String(symbol)) {
                decodedText += String(symbol)
                continue
            }
            var makingCalculations = true
            while makingCalculations {
                let characterIndex = symbol.code - indexOffset
                
                let decodedIndex = module * wholePart + characterIndex - firstKey
                if decodedIndex >= 0 && decodedIndex % secondKey == 0 {
                    let decodedSymbolCode = Int(decodedIndex / secondKey) + indexOffset
                    let decodedSymbol = Character(UnicodeScalar(decodedSymbolCode)!)
                    decodedText += String(decodedSymbol)
                    makingCalculations = false
                    break
                }
                else {
                    wholePart += 1
                }
            }
        }
        return decodedText
    }
    
}
