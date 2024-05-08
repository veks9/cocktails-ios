//
//  Encodable+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

extension Encodable {
    var data: Data? {
        if let data = self as? Data {
            return data
        }
        return try? JSONEncoder().encode(self)
    }

    var dictionaryOptional: [String: Any]? {
        guard let data = data else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
