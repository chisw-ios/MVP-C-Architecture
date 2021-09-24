//
//  Date.swift
//  PharmacyPortal
//
//  Created by user on 04.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
extension Date: Strideable {}
extension Date {
    
    func dateToString (with format: String, locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
        
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date? {
        let date = Calendar.current.startOfDay(for: self)
        return date.add(.day, value: 1)
    }
    
    func getMonthStart() -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.month, .weekOfMonth, .year], from: self)
        components.weekOfMonth = 0
        return calendar.date(from: components)
    }
    
    func getYearStart() -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year], from: self)
        return calendar.date(from: components)
    }
    
    func add(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
    
    var millisecondsSince1970: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}



