//
//  GetAlcoholicFiltersRequest.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation
import Alamofire

struct GetAlcoholicFiltersRequest: APIRequest {
    typealias ResponseType = Model.Response<[Model.AlcoholicFilter]>
    
    var path: String {
        Endpoint.list.path
    }
    
    var query: [String : String?]? {
        [
            "a": "list"
        ]
    }
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType = .applicationJson
}
