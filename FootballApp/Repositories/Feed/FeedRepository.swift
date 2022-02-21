//
//  FeedRepository.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

protocol FeedRepositoryProtocol {
    func getFeed(success: @escaping (FeedResponse) -> Void, failure: @escaping (String)  -> Void)
}

class FeedRepository: FeedRepositoryProtocol {
    private var apiClient: APIProtocol
    
    init(apiClient: APIProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getFeed(success: @escaping (FeedResponse) -> Void, failure: @escaping (String) -> Void) {
        let request = FeedRequest.getFeed
        apiClient.makeRequest(request) { (response: FeedResponse) in
            success(response)
        } failure: { error in
            failure(error)
        }

    }
    
}
