//
//  FeedViewModel.swift
//  FootballApp
//
//  Created by Mehmed on 2/21/22.
//

import Foundation

class FeedViewModel {
    var feedMatches : Observable<[Match]> = Observable([])
    var errorMessage: Observable<String> = Observable(String())
    var showError: Observable<Bool> = Observable(false)
    
    private let feedRepository: FeedRepositoryProtocol
    
    init(feedRepository: FeedRepositoryProtocol = FeedRepository()) {
        self.feedRepository = feedRepository
    }
}

// MARK: - API Calls
extension FeedViewModel {
    func getFeed(){
        feedRepository.getFeed { [weak self] feed in
            self?.feedMatches.value = feed.data.sorted(by: {$0.date > $1.date})
        } failure: { [weak self] error in
            self?.errorMessage.value = error
            self?.showError.value = true
        }
    }
}
