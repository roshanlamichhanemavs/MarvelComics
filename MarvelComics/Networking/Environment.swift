//
//  Environment.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation

// MARK: - Sets up environment configuratio
struct Environment {
    static let baseURL = "https://gateway.marvel.com"
    static let publicApiKey = "7f1f1e090d36f4b5e99625603acdb813"
    
    // Separate endpoints
    struct Endpoint: RawRepresentable {
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    // Parameters for request
    struct Parameter {
        var key: String
        var value: String
        
        init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    }
    
    /**
         Resolves information related to constructing the api request
     - parameters:
        - endpoint: String endpoint appeneded to base url
        - `parameters`: String parameter passed on the url
        - queryParameters: [URLQueryItem] passed as query items
     */
    func resolvedURL(for endpoint: Environment.Endpoint, resolvingParameters parameters: [Environment.Parameter]? = nil, queryParameters: [URLQueryItem]? = nil) -> NetworkRequest? {
        var rawEndPoint = endpoint.rawValue
        parameters?.forEach({ parameters in
            rawEndPoint = rawEndPoint.replacingOccurrences(of: parameters.key, with: parameters.value.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")
        })
        
        let fullURLString = "\(Self.baseURL)\(rawEndPoint)"
        let timestampForRequest = Int(Date().timeIntervalSince1970)
        // Separately provide private api key because of security concern
        guard let hashedKey = "\(timestampForRequest)\(ApiKeyLocator.privateApiKey)\(Self.publicApiKey)".convertTomd5() else {
            fatalError("Cannot proceed without valid api keys")
        }
        
        var encodedParameterDictionary: [String: Any]? = [
            "apikey": Self.publicApiKey,
            "ts": timestampForRequest,
            "hash": hashedKey
        ]
        
        // Also updating query parameters
        if let queryParameters = queryParameters {
            queryParameters.forEach { items in
                encodedParameterDictionary?[items.name] = items.value
            }
        }
        
        guard let fullURL = URL(string: fullURLString) else {
            fatalError("URL should be correctly constructed")
        }
        
        return NetworkRequest(method: .get, url: fullURL, queryParameters: encodedParameterDictionary)
    }
}

extension Environment.Endpoint {
    static let character = Environment.Endpoint(rawValue: "/v1/public/characters")
    // If we want to make the api call with character identifier
    static let uniqueCharacter = Environment.Endpoint(rawValue: "/v1/characters/{{characterIdentifier}}")
}

extension Environment.Parameter {
    static func character(with uniqueIdentifier: String) -> Environment.Parameter {
        Environment.Parameter(key: "{{character}}", value: uniqueIdentifier)
    }
}
