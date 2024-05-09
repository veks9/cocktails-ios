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

        let startOfDay = calendar.startOfDay(for: now)
        let startOfThisWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfDay))!
        let startOfThisMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: startOfDay))!
        let startOfThisYear = calendar.date(from: calendar.dateComponents([.year], from: startOfDay))!

        if self >= startOfThisYear {
            if self >= startOfThisMonth {
                if self >= startOfThisWeek {
                    if self >= startOfDay {
                        return Localization.relativeDateToday.localized()
                    } else {
                        return Localization.relativeDateThisWeek.localized()
                    }
                } else {
                    return Localization.relativeDateThisMonth.localized()
                }
            } else {
                return Localization.relativeDateThisYear.localized()
            }
        } else {
            let yearsDifference = calendar.dateComponents([.year], from: self, to: now).year!
            return yearsDifference == 1 ?
            Localization.relativeDateYearAgo.localized(yearsDifference) :
            Localization.relativeDateYearsAgo.localized(yearsDifference)
        }
    }
}
