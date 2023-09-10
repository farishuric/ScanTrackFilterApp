//
//  String+Extensions.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import Foundation

extension String {
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
