//
//  String+Formatting.swift
//  Social IQ
//

import Foundation

extension String {
    var sentenceFormatted: String {
        replacingOccurrences(of: ". ", with: ".\n")
    }
}
