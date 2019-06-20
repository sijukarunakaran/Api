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
    var baseEndpointUrl: URL { get }
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


extension APIRequest {
    
    var urlRequest: URLRequest {
        let endpoint = self.endpoint()
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.header?.dictionary as? [String : String]
        urlRequest.httpBody = bodyParams()
        return urlRequest
    }
    
    /// Encodes request body based on the given request
    private func bodyParams() -> Data?{
        guard let bodyParams = self.body else{
            return nil
        }
        do {
            return try JSONEncoder().encode(bodyParams)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
    }
    
    /// Encodes a URL based on the given request
    private func endpoint() -> URL {
        guard let baseUrl = URL(string: self.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Bad resourceName: \(self.resourceName)")
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        
        // Common query items needed for all requests
        let commonQueryItems = [URLQueryItem]()
        
        //TODO If any common query mention here
        
        // Custom query items needed for this specific request
        let customQueryItems: [URLQueryItem]
        
        do {
            customQueryItems = try URLQueryItemEncoder.encode(self.queryParams)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        
        components.queryItems = commonQueryItems + customQueryItems
        
        // Construct the final URL with all the previous data
        return components.url!
    }
}
