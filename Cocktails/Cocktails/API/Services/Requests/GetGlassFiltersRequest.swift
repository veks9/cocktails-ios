//
//  GetGlassFiltersRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation
import Alamofire

struct GetGlassFiltersRequest: APIRequest {
    typealias ResponseType = Model.Response<[Model.GlassFilter]>
    
    var path: String {
        Endpoint.list.path
    }
    
    var query: [String : String?]? {
        [
            "g": "list"
        ]
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}
