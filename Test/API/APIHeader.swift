//
//  APIHeader.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

struct ContentType {
    static var json = "application/json"
}

struct APIHeader: Encodable {
    
    let authentication: String?
    let authenticationKey: String
    let contentType: String
    let acceptType: String
    let acceptEncoding: String?
    
    enum CodingKeys: String, CodingKey {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    init(authentication: String? = nil, authenticationKey: String = "Bearer", contentType: String = ContentType.json, acceptType: String = ContentType.json, acceptEncoding: String? = nil) {
        self.authentication = authentication
        self.contentType = contentType
        self.acceptType = acceptType
        self.acceptEncoding = acceptEncoding
        self.authenticationKey = authenticationKey
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let authorization = authentication{
            try container.encodeIfPresent("\(authenticationKey) \(authorization)", forKey: .authentication)
        }
        try container.encodeIfPresent(contentType, forKey: .contentType)
        try container.encodeIfPresent(acceptType, forKey: .acceptType)
        try container.encodeIfPresent(acceptEncoding, forKey: .acceptEncoding)
    }
}

