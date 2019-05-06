//
//  PostViewModel.swift
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

class PostViewModel: ViewModel {
    public typealias ResultType = Posts
    
    var error: Error?
    
    var result: ResultType?
    
    var state: ViewModelState = .loading{
        didSet{
            self.didChangeState?()
        }
    }
    
    var didChangeState: (() -> Void)?
    
    func getPosts(){
        state = .loading
        APIClient()?.perform(GetPosts(page: 1, accessKey: APIClient.environment.accessKey), completion: { (response) in
            switch response{
            case .success(let value):
                self.result = value
                self.state = .dataAvailable
            case .failure(let error):
                self.error = error
                self.state = .error
            }
        })
    }
    
}
