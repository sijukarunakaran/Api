//
//  APIClient.swift
//  Test
//
//  Created by Siju Karunakaran on 12/04/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//


import Foundation
import UIKit

public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void



/// Implementation of a generic-based API client
public class APIClient {
    
    private var baseEndpointUrl:URL
	private let session = URLSession(configuration: .default)
    public static var environment: Environment = .development
    
    convenience init?() {
        self.init(baseUrl: APIClient.environment.baseUrl)
    }
    
    public init?(baseUrl: String){
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        baseEndpointUrl = url
    }

	/// Sends a request to servers, calling the completion method when finished
	public func perform<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.SuccessResponseType>) {
		let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
//        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header?.dictionary as? [String : String]
        urlRequest.httpBody = body(for: request)
		let task = session.dataTask(with: urlRequest) { data, response, error in
			if let data = data {
                self.decode(request, data: data, completion: completion)
			} else if let error = error {
				completion(.failure(error))
			}
		}
		task.resume()
	}
    
    /// Decode data based on the given request
    private func decode<T: APIRequest>(_ request: T, data: Data, completion: @escaping ResultCallback<T.SuccessResponseType>) {
        
        let apiResponse = Result{ try JSONDecoder().decode(T.SuccessResponseType.self, from: data) }
        
        switch apiResponse {
            case .success:
                completion(apiResponse)
            default:
                let errorMessage = Result{ try JSONDecoder().decode(T.ErrorResponseType.self, from: data).errorMessage }
                switch errorMessage {
                    case .success(let message):
                        completion(.failure(APIError.server(message: message)))
                    default:
                        completion(apiResponse)
                }
        }
    }
    
    /// Encodes request body based on the given request
    private func body<T: APIRequest>(for request: T) -> Data?{
        guard let bodyParams = request.body else{
            return nil
        }
        do {
            return try JSONEncoder().encode(bodyParams)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
    }

	/// Encodes a URL based on the given request
	private func endpoint<T: APIRequest>(for request: T) -> URL {
		guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
			fatalError("Bad resourceName: \(request.resourceName)")
		}

		var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        
		// Common query items needed for all requests
        let commonQueryItems = [URLQueryItem]()
      
        //TODO If any common query mention here

		// Custom query items needed for this specific request
		let customQueryItems: [URLQueryItem]

		do {
			customQueryItems = try URLQueryItemEncoder.encode(request.queryParams)
		} catch {
			fatalError("Wrong parameters: \(error)")
		}

		components.queryItems = commonQueryItems + customQueryItems

		// Construct the final URL with all the previous data
		return components.url!
	}
}
