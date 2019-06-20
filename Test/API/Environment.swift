//
//  Environment.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

protocol HostDetails {
    var baseURLString: String { get set }
    var clientID: String? { get set }
    var clientSecret: String? { get set }
    var accessKey : String? { get set }
}
extension HostDetails {
    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {
            fatalError("Bad Base URL")
        }
        return url
    }

}

public struct Host: HostDetails {
    
    var baseURLString: String
    
    var clientID: String?
    
    var clientSecret: String?
    
    var accessKey: String?
    
    
    
}
public enum Environment{
    
    case development
    case production
    
    
    public static var current: Environment = .development
    
    
    public var host: Host{
        switch self {
        case .development:
            return Host(baseURLString: "https://api.unsplash.com",
                        clientID: nil,
                        clientSecret: nil,
                        accessKey: "8634366274bd23efb9b023fb9b2c6502e67f7dd5d6a7962b3b49fbee170940f8")
        case .production:
            return Host(baseURLString: "https://api.unsplash.com",
                        clientID: nil,
                        clientSecret: nil,
                        accessKey: "8634366274bd23efb9b023fb9b2c6502e67f7dd5d6a7962b3b49fbee170940f8")
        }
    }
}


