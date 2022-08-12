//
//  MarvelCharactersViewModel.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/10/22.
//

import Foundation

class MarvelCharactersViewModel {
    typealias MarvelCharacterInformation = ([MarvelCharacter]) -> Void
    let environment: Environment
    let endPoint: Environment.Endpoint

   
   
    init(environment: Environment, endPoint: Environment.Endpoint) {
        self.environment = environment
        self.endPoint = endPoint
    }
    
    // MARK: - Api Request and Response handler
    
    /**
     Fetches marvel characters from disney api and builds view model
     */
    func fetchMarvelCharacters(_ completionHandler: @escaping MarvelCharacterInformation) {
        guard let resolvedURL = environment.resolvedURL(for: .character) else { return }
          let networkClient = NetworkClient(networkRequest: resolvedURL)
        networkClient.makeNetworkRequest(with: { marvelCharacters, error  in
            guard let marvelCharacters = marvelCharacters?.characters else {
                debugPrint("Handle error or nil")
                return
            }
            
            completionHandler(marvelCharacters.sorted())
        })
    }
    
}



