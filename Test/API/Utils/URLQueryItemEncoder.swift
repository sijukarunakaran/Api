//
//  URLQueryItemEncoder.swift
//  Test
//
//  Created by Siju Karunakaran on 12/04/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//


import Foundation

/// Encodes any encodable to a URLQueryItem list
enum URLQueryItemEncoder {
	static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
		let parametersData = try JSONEncoder().encode(encodable)
		let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
		return parameters.map { URLQueryItem(name: $0, value: $1.description) }
	}
}
