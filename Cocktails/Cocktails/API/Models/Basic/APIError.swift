//
//  APIError.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation
import Alamofire

extension Model {
    struct APIError: Error, Codable {
        let errorMessage: String
        let statusCode: Int?

        init(
            errorMessage: String,
            statusCode: Int?
        ) {
            self.errorMessage = errorMessage
            self.statusCode = statusCode
        }

        init(from error: Error) {
            errorMessage = error.localizedDescription
            statusCode = nil
        }

        init(from afError: AFError) {
            errorMessage = afError.localizedDescription
            statusCode = nil
        }
    }
}

