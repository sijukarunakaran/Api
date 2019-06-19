//
//  APIRequest.swift
//  Test
//
//  Created by Siju Karunakaran on 12/04/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//


import Foundation

/// All requests must conform to this protocol
public protocol APIRequest {
	/// Type to decode incoming json
	associatedtype SuccessResponseType: Decodable
    /// Type to encapsulate query params
    associatedtype QueryParamsType: Encodable
    /// Type to encapsulate body
    associatedtype BodyType: Encodable
    ///Error Type
    associatedtype ErrorResponseType: APIErrorResponse
    
    ///Api http method
    var method: HTTPMethod { get }
	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
    /// Query params
    var queryParams: QueryParamsType? { set get }
    /// Request body
    var body: BodyType? { set get }
    ///Header fields
    var header: APIHeader? { get }
}
