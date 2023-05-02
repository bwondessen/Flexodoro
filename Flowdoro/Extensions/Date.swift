//
//  Date.swift
//  Flexodoro
//
//  Created by Bruke on 4/29/23.
//

import Foundation

extension Date {
    static func sunday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        //let monday = calendar.date(byAdding: .day, value: 1, to: sunday)!
        
        return sunday
    }
    
    static func monday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let monday = calendar.date(byAdding: .day, value: 1, to: sunday)!
        
        return monday
    }
    
    static func tuesday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let tuesday = calendar.date(byAdding: .day, value: 2, to: sunday)!
        
        return tuesday
    }
    
    
    static func wednesday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let wednesday = calendar.date(byAdding: .day, value: 3, to: sunday)!
        
        return wednesday
    }
    
    static func thursday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let thursday = calendar.date(byAdding: .day, value: 4, to: sunday)!
        
        return thursday
    }
    
    static func friday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let friday = calendar.date(byAdding: .day, value: 5, to: sunday)!
        
        return friday
    }
    
    static func saturday(using calendar: Calendar) -> Date {
        let sunday = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        let saturday = calendar.date(byAdding: .day, value: 6, to: sunday)!
        
        return saturday
    }
    
    static func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day, .month, .year], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
        
//        if Calendar.current.dateComponents([.day, .month, .year], from: date1) == Calendar.current.dateComponents([.day, .month, .year], from: date2) {
//            return true
//        } else {
//            return false
//        }
    }
}
