//
//  SearchCocktailsRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation
import Alamofire

struct SearchCocktailsRequest: APIRequest {
    typealias ResponseType = Model.Drinks
    
    var path: String {
        Endpoint.search.path
    }
    
    let searchQuery: String?
    var query: [String : String?]? {
        [
            "s": searchQuery
        ]
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}

