//
//  GetCocktailDetailsRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Foundation
import Alamofire

struct GetCocktailDetailsRequest: APIRequest {
    typealias ResponseType = Model.Drinks
    
    var path: String {
        Endpoint.details.path
    }
    
    let id: String
    var query: [String : String?]? {
        [
            "i": id
        ]
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}

