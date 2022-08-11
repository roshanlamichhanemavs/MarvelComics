//
//  HashConverter.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import Foundation
import CryptoKit

extension String {
    // Convert String to hexadecimal md5
    func convertTomd5() -> Self? {
        guard let data = self.data(using: .utf8) else { return nil }
        let cryptoSecure = Insecure.MD5.hash(data: data)
        return cryptoSecure.map {
                String(format: "%02hhx", $0)
            }.joined()
    }
}
