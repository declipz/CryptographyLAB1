//
//  Encoder.swift
//  cryptography
//
//  Created by Vladislav Kondrashkov on 9/17/18.
//  Copyright © 2018 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

class Encoder {
    private let punctuationMarks = [",", ".", " ", "!", "?", ":", ";"]
    private let russianAlphabetOffset = 1040
    private let englishAlphabetOffset = 65
    
    func encodeText(_ sourceText: String, with firstKey: Int, and secondKey: Int, by module: Int) -> String {
        var indexOffset: Int = 0;
        
        if module == 26 {
            indexOffset = englishAlphabetOffset
        }
        else if module == 33 {
            indexOffset = russianAlphabetOffset
        }
        
        var encodedText: String = ""
        for symbol in sourceText {
            if punctuationMarks.contains(String(symbol)) {
                encodedText += String(symbol)
                continue
            }
            var characterIndex = symbol.code - indexOffset
            var lowerCased = false
            if characterIndex >= 32 {
                lowerCased = true
                characterIndex -= 32
            }
            
            var newSymbolCode = (characterIndex * secondKey + firstKey) % module + indexOffset
            if lowerCased {
                newSymbolCode += 32
            }
            let newSymbol = Character(UnicodeScalar(newSymbolCode)!)
            encodedText += String(newSymbol)
        }
        
        return encodedText
    }
    
    func decodeText(_ encodedText: String, with firstKey: Int, and secondKey: Int, by module: Int) -> String {
        var indexOffset: Int = 0;
        
        if module == 26 {
            indexOffset = englishAlphabetOffset
        }
        else if module == 33 {
            indexOffset = russianAlphabetOffset
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
                var characterIndex = symbol.code - indexOffset
                var lowerCased = false
                if characterIndex >= 32 {
                    lowerCased = true
                    characterIndex -= 32
                }
                
                let decodedIndex = module * wholePart + characterIndex - firstKey
                if decodedIndex >= 0 && decodedIndex % secondKey == 0 {
                    var decodedSymbolCode = Int(decodedIndex / secondKey) + indexOffset
                    if lowerCased {
                        decodedSymbolCode += 32
                    }
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
