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
        urlRequest.allHTTPHeaderFields = request.header?.dictionary as? [String : String]
        
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
            do {
                // Decode the top level response, and look up the decoded response to see
                // if it's a success
                let apiResponse = try JSONDecoder().decode(T.SuccessResponseType.self, from: data)
                completion(.success(apiResponse))
                
            } catch {
                do {
                    // if it's  a failure
                    let errorMessage = try JSONDecoder().decode(T.ErrorResponseType.self, from: data).errorMessage
                    completion(.failure(APIError.server(message: errorMessage)))
                    
                } catch {
                    completion(.failure(error))
                }
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
			customQueryItems = try URLQueryItemEncoder.encode(request)
		} catch {
			fatalError("Wrong parameters: \(error)")
		}

		components.queryItems = commonQueryItems + customQueryItems

		// Construct the final URL with all the previous data
		return components.url!
	}
}
