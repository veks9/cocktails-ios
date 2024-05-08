//
//  Date+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation

extension Date {
    func toRelativeDate() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: now)
        
        if let year = components.year, year > 0 {
            return year == 1 ?
            "relative_date_year_ago".localized(year) :
            "relative_date_years_ago".localized(year)
        }
        if let month = components.month, month > 0 {
            return "relative_date_this_month".localized()
        }
        if let week = components.weekOfYear, week > 0 {
            return "relative_date_this_week".localized()
        }
        if let day = components.day, day > 0 {
            return "relative_date_today".localized()
        }
        
        return "relative_date_unknown".localized()
    }
}
