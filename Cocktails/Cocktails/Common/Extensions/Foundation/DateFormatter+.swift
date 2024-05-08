//
//  DateFormatter+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation

extension DateFormatter {
    static let apiFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter
    }()
}
