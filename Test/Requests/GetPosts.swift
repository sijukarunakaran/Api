//
//  GetPhotos.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public struct GetPosts: APIRequest {
    
    public struct QueryParams: Encodable {
        let page: Int
    }
    
    public struct Body: Encodable {
        
    }
    
    public typealias QueryParamsType = GetPosts.QueryParams
    public typealias BodyType = Body
    public typealias SuccessResponseType = Posts
    public typealias ErrorResponseType = ErrorResponse
    
    public var method: HTTPMethod{
        return .get
    }
    public var queryParams: QueryParamsType? = nil
    public var body: BodyType? = nil
    
    public var header: APIHeader?{
        return APIHeader(authentication: APIClient.environment.accessKey, authenticationKey: APIHeader.AuthenticationKey.clientID)
    }
    
    public var resourceName: String {
        return "photos"
    }
    
}

