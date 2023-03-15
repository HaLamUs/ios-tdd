//
//  DateSpan.swift
//  testDateSpan
//
//  Created by lamha on 15/03/2023.
//

import Foundation

public enum DateSpan {
    case none,
    today,
    yesterday,
    threeDays,
    custom(Date, Date)
    
    public func span(_ currentDate: Date = Date()) -> (startDate: Date?, endDate: Date?) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        switch self {
        case .none:
            return (Date(), Date())
        case .today:
            let startDate = calendar.startOfDay(for: currentDate)
            
            var components = DateComponents()
            components.day = 1
            components.second = -1
            let endDate = calendar.date(byAdding: components, to: startDate)
            return (startDate, endDate)
        case .yesterday:
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let startYesterday = calendar.startOfDay(for: yesterday)
            var components = DateComponents()
            components.day = 1
            components.second = -1
            let endYesterday = calendar.date(byAdding: components, to: startYesterday)
            return (startYesterday, endYesterday)
        case .threeDays: return (Date(), Date())
        case .custom(let date1, let date2):
            return (Date(), Date())
        }
        
        
    }
    
}
