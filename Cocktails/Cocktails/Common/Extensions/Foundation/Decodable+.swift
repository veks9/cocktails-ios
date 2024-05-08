//
//  Decodable+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            guard let date = DateFormatter.apiFormat.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot decode date string \(dateString)"
                )
            }
            return date
        })

        return jsonDecoder
    }()
}
