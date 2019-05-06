//
//  GetPhotos.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public struct GetPosts: APIRequest {    
    
    public typealias SuccessResponseType = Posts
    public typealias ErrorResponseType = ErrorResponse
    
    public var header: Encodable?{
        return APIHeader(authentication: accessKey, authenticationKey: "Client-ID")
    }
    
    public var resourceName: String {
        return "photos"
    }
    
    let page: Int
    let accessKey: String
    
    private enum CodingKeys: String, CodingKey {
        case page
    }
    
}

