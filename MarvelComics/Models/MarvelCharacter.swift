//
//  Characters.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation

// MARK: - Construct Specific Marvel Character
struct MarvelCharacter: Decodable {
    var characterIdentifer: Int
    var name: String
    var characterDescription: String?
    var imageURLPathWithExtension: URL?
    var comics: [ComicBook]?
    
    private enum CharacterKeys: String, CodingKey {
        case characterIdentifer = "id"
        case name
        case characterDescription = "description"
        case imageURLPathWithExtension = "thumbnail"
        case comics
    }
    
    private enum ImageInformationKeys: String, CodingKey {
        case thumbnailURL =  "path"
        case imageExtension = "extension"
    }
    
    private enum ComicsKeys: String, CodingKey {
        case items
    }
    
}

extension MarvelCharacter {
    init(from decoder: Decoder) throws {
        let decodingValues = try decoder.container(keyedBy: CharacterKeys.self)
        characterIdentifer = try decodingValues.decode(Int.self, forKey: .characterIdentifer)
        name = try decodingValues.decode(String.self, forKey: .name)
        characterDescription = try? decodingValues.decode(String.self, forKey: .characterDescription)
        // Since comic is nested, we will decode the nested values
        let comicInformation = try? decodingValues.nestedContainer(keyedBy: ComicsKeys.self, forKey: .comics)
        comics = try? comicInformation?.decode([ComicBook].self, forKey: .items)
        
        // Since image information is nested, we will decode the nested values
        let imageInfo = try? decodingValues.nestedContainer(keyedBy: ImageInformationKeys.self, forKey: .imageURLPathWithExtension)
        let imageURLPath = try imageInfo?.decode(String.self, forKey: .thumbnailURL)
        let imageExtension = try? imageInfo?.decode(String.self, forKey: .imageExtension)
        guard let imageURLPath = imageURLPath, let imageExtension = imageExtension, let fullImagePath = URL(string: imageURLPath+"."+imageExtension) else {
            imageURLPathWithExtension = nil
            return
        }
        imageURLPathWithExtension = fullImagePath
       
       
    }
}

// Confirming to Comparable to allow sorting of characters
extension MarvelCharacter: Comparable {
    static func < (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        lhs.characterIdentifer < rhs.characterIdentifer
    }
    
    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        lhs.characterIdentifer > rhs.characterIdentifer
    }
    
    
}
