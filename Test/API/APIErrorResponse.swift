//
//  APIErrorResponse.swift
//  Test
//
//  Created by Siju on 06/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public protocol APIErrorResponse: Decodable {
    var errorMessage: String{ get }
}
