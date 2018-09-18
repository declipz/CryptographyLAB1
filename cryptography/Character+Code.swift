//
//  Character+Code.swift
//  cryptography
//
//  Created by Vladislav Kondrashkov on 9/18/18.
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
