//
//  AuthenticatedNetworkRequest.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation
import Alamofire

class NetworkRequest {
    var method: HTTPMethod
    var url: URL
    var queryParameters: [String: Any]?
    
    public init(method: HTTPMethod = .get, url: URL, queryParameters: [String: Any]?) {
        self.method = method
        self.url = url
        self.queryParameters = queryParameters
    }
}

