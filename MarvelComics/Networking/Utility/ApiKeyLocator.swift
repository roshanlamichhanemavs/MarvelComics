//
//  ApiKeyLocator.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation

class ApiKeyLocator {
    static var privateApiKey: String {
        guard let infoPlist: [String: Any] = Bundle.main.infoDictionary, let privateApiKey = infoPlist["PRIVATE_API_KEY"] as? String else { return ""}
        return privateApiKey
    }
}
