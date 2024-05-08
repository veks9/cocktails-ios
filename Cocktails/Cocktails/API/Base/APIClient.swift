//
//  APIClient.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Alamofire
import Combine
import Foundation

final class APIClient {
    
    static let shared = APIClient()
    
    private let decoder = JSONDecoder.default
    
    private init() {}
    
    private func dataRequest<T: APIRequest>(for request: T) -> DataRequest {
        if request.contentType == .applicationJson {
            return AF.request(request)
        } else {
            let urlRequest = request.urlRequest!
            return AF.request(
                urlRequest.url!,
                method: request.httpMethod,
                parameters: request.requestBody?.dictionaryOptional,
                encoding: URLEncoding(arrayEncoding: .indexInBrackets),
                headers: urlRequest.headers,
                interceptor: nil,
                requestModifier: nil
            )
        }
    }
}

// MARK: - Internal functions

extension APIClient {
    func performRequest<T: APIRequest>(_ request: T) -> Future<T.ResponseType, Model.APIError> {
        Future<T.ResponseType, Model.APIError> { promise in
            self.dataRequest(for: request)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<T.ResponseType, AFError>) in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let afError):
                        do {
                            _ = try self.decoder.decode(T.ResponseType.self, from: response.data ?? Data())
                        } catch {
                            // debug
                            print("💚💚💚💚💚DECODABLE ERROR💚💚💚💚💚")
                            print(error)
                        }
                        do {
                            let errorResponse = try self.decoder.decode(Model.APIError.self, from: response.data ?? Data())
                            promise(.failure(errorResponse))
                        } catch {
                            promise(.failure(Model.APIError(errorMessage: "Unknown", statusCode: 400)))
                        }
                    }
                }
        }
    }
}

