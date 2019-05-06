//
//  ViewModel.swift
//  Test
//
//  Created by Siju on 06/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

enum ViewModelState{
    case loading
    case error
    case dataAvailable
}

protocol ViewModel {
    associatedtype ResultType: Decodable
    var error: Error? { get set }
    var result: ResultType? { get set }
    var state: ViewModelState { get set }
    var didChangeState: (()->Void)? { get set }
}
