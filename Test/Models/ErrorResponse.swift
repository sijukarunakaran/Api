//
//  ErrorResponse.swift
//  Test
//
//  Created by Siju on 06/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public struct ErrorResponse: APIErrorResponse {
    let errors: [String]
    public var errorMessage: String{
        return errors.joined(separator: "\n")
    }
}
