//
//  Double.swift
//  Flowdoro
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
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
      }
}
