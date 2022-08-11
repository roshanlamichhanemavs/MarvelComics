//
//  MarvelCharacters.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation

struct MarvelCharacters: Decodable {
    var characters: [MarvelCharacter]
    
    enum DataKey: String, CodingKey {
        case data
    }
    
    enum CharactersKey: String, CodingKey {
        case marvelCharacters = "results"
    }
}

extension MarvelCharacters {
    init(from decoder: Decoder) throws {
        let decodingValues = try decoder.container(keyedBy: DataKey.self)
        let result = try decodingValues.nestedContainer(keyedBy: CharactersKey.self, forKey: .data)
        characters = try result.decode([MarvelCharacter].self, forKey: .marvelCharacters)
    }
}
