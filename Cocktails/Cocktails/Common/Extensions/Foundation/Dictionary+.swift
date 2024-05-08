//
//  Dictionary+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation

extension Dictionary {
    mutating func addIfKeyIsNotNull(_ key: Key?, _ value: Value) where Key: Hashable {
        if let key = key {
            updateValue(value, forKey: key)
        }
    }
}
