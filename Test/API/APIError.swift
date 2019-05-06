//
//  APIError.swift
//  Test
//
//  Created by Siju Karunakaran on 13/04/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case encoding
    case decoding
    case server(message: String)
}
extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decoding:
            return "JSON Decode Error"
        case .encoding:
            return "JSON Encode Error"
        case .server(let message):
            return message
        }
    }
}
