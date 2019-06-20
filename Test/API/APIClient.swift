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
    
	private let session = URLSession(configuration: .default)

	/// Sends a request to servers, calling the completion method when finished
	public func perform<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.SuccessResponseType>) {
        let urlRequest = request.urlRequest
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
}
