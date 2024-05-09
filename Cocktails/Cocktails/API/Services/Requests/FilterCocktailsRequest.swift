//
//  FilterCocktailsRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import Foundation
import Alamofire

struct FilterCocktailsRequest: APIRequest {
    typealias ResponseType = Model.Response<[Model.Drink]>
    
    var path: String {
        Endpoint.filter.path
    }
    
    let alcoholicFilter: String?
    let categoryFilter: String?
    let glassFilter: String?
    var query: [String : String?]? {
        var dict: [String : String?] = [:]
        
        if let alcoholicFilter {
            dict["a"] = alcoholicFilter
        }
        
        if let categoryFilter {
            dict["c"] = categoryFilter
        }
        
        if let glassFilter {
            dict["g"] = glassFilter
        }
        
        return dict
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}

