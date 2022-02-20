//
//  FeedRepository.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

protocol FeedRepositoryProtocol {
    func getFeed(success: @escaping (Feed) -> Void, failure: @escaping (String)  -> Void)
}

class FeedRepository: FeedRepositoryProtocol {
    private var apiClient: FootballAPIProtocol
    
    init(apiClient: FootballAPIProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getFeed(success: @escaping (Feed) -> Void, failure: @escaping (String) -> Void) {
        let request = FeedRequest.getFeed
        apiClient.submitRequest(footballRequest: request) { (response: Feed) in
            success(response)
        } failure: { error in
            failure(error)
        }

    }
    
}
