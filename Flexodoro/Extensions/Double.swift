//
//  Double.swift
//  Flexodoro
//
//  Created by Bruke on 10/25/22.
//

import Foundation

extension Double {
    /// Converts a Double into String representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
