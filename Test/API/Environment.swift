//
//  Environment.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public enum Environment{
    case development
    case production
    
    var accessKey: String{
        switch self {
        case .development:
            return "8634366274bd23efb9b023fb9b2c6502e67f7dd5d6a7962b3b49fbee170940f8"
        case .production:
            return "8634366274bd23efb9b023fb9b2c6502e67f7dd5d6a7962b3b49fbee170940f8"
        }
    }
    
    var baseUrl: String{
        switch self {
        case .development:
            return "https://api.unsplash.com"
        case .production:
            return "https://api.unsplash.com"
        }
    }
}
