//
//  GetCategoryFiltersRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation
import Alamofire

struct GetCategoryFiltersRequest: APIRequest {
    typealias ResponseType = Model.Response<[Model.CategoryFilter]>
    
    var path: String {
        Endpoint.list.path
    }
    
    var query: [String : String?]? {
        [
            "c": "list"
        ]
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}
