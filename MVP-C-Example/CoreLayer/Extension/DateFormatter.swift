//
//  DateFormatter.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 05.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let monthYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static let monthDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static let yearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    static func transformStringDate(_ dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {
        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat

        guard let initialDate = initalFormatter.date(from: dateString) else {
            print ("Error in dateString = \(dateString) or in fromDateFormat = \(fromDateFormat)")
            return nil
        }

        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat

        return resultFormatter.string(from: initialDate)
    }
}




