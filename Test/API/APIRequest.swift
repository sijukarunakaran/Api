//
//  APIRequest.swift
//  Test
//
//  Created by Siju Karunakaran on 12/04/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//


import Foundation

/// All requests must conform to this protocol
/// - Discussion: You must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol APIRequest: Encodable {
	/// Response
	associatedtype SuccessResponseType: Decodable
    associatedtype ErrorResponseType: APIErrorResponse

	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
    
    var header: Encodable? { get }
}
