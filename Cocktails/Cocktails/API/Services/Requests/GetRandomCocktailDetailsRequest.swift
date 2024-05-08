//
//  GetRandomCocktailDetailsRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation
import Alamofire

struct GetRandomCocktailDetailsRequest: APIRequest {
    typealias ResponseType = Model.Drinks
    
    var path: String {
        Endpoint.random.path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}

