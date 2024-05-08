//
//  APIRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Alamofire
import Foundation

protocol APIRequest: URLRequestConvertible {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var query: [String: String?]? { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
    var authenticationType: AuthenticationType { get }
    var contentType: ContentType { get }
}

extension APIRequest {

    func urlRequest() -> URLRequest {
        let url = URL(string: path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.setValue(contentType.httpHeaderText, forHTTPHeaderField: "Content-Type")
        query == nil ? () : query?.forEach { urlRequest.url?.appendQueryItem(name: $0.key, value: $0.value) }

        switch authenticationType {
        case .none:
            break
        }

        return urlRequest
    }

    func asURLRequest() throws -> URLRequest {
        urlRequest()
    }
}


