//
//  NetworkingClient.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation
import Alamofire

class NetworkClient {
    let networkRequest: NetworkRequest
   
    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }
    
    func makeNetworkRequest(with completionHandler: @escaping (MarvelCharacters?, Error?) -> Void) {
        _ = AF.request(networkRequest.url, method: networkRequest.method, parameters: networkRequest.queryParameters, encoding: URLEncoding.default) .validate().responseDecodable(of: MarvelCharacters.self) { response in
            switch response.result {
            case .success(let characters):
                completionHandler(characters, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}
