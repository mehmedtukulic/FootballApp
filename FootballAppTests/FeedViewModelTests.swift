//
//  FeedViewModelTests.swift
//  FootballAppTests
//
//  Created by Mehmed on 2/21/22.
//

import XCTest

class FeedViewModelTests: XCTestCase {

    func testGettingFeedSuccess() throws {
        let repository = MockFeedRepository1()
        let viewModel = FeedViewModel(feedRepository: repository)
        
        XCTAssertEqual(viewModel.feedMatches.value, [])
        
        viewModel.getFeed()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 3 seconds")], timeout: 3.0)
        
        viewModel.feedMatches.bind { matches in
            XCTAssertNotNil(matches)
            XCTAssertEqual(matches, repository.matches)
        }
        
        viewModel.showError.bind { showError in
            XCTAssertEqual(showError, false)
        }
    }
    
    func testGettingFeedEmpty() throws {
        let repository = MockFeedRepository2()
        let viewModel = FeedViewModel(feedRepository: repository)
        
        viewModel.getFeed()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 3 seconds")], timeout: 3.0)
        
        viewModel.feedMatches.bind { matches in
            XCTAssertEqual(matches, [])
        }
        
        viewModel.showError.bind { showError in
            XCTAssertEqual(showError, false)
        }
    }

    func testGettingFeedFailure() throws {
        let repository = MockFeedRepository3()
        let viewModel = FeedViewModel(feedRepository: repository)
        
        viewModel.feedMatches.bind { matches in
            XCTAssertEqual(matches, [])
        }
        
        viewModel.getFeed()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 3 seconds")], timeout: 3.0)
        
        viewModel.errorMessage.bind { message in
            XCTAssertEqual(message, "Error")
        }
        
        viewModel.showError.bind { showError in
            XCTAssertEqual(showError, true)
        }
    }

}

class MockFeedRepository1: FeedRepositoryProtocol {
    let matches: [Match] = [
        .init(
            id:String("1"),
              feedMatchId: 1,
              competition: String(),
              period: String(),
              minute: 90,
              date: String(),
              homeTeam: Team(id: String(), name: String(), score: 1),
              awayTeam: Team(id: String(), name: String(), score: 1),
              venue: Venue(id: 1, name: String(), location: String())
        ),
        .init(
            id:String("2"),
              feedMatchId: 1,
              competition: String(),
              period: String(),
              minute: 90,
              date: String(),
              homeTeam: Team(id: String(), name: String(), score: 1),
              awayTeam: Team(id: String(), name: String(), score: 1),
              venue: Venue(id: 1, name: String(), location: String())
        )
    ]
    
    func getFeed(success: @escaping (FeedResponse) -> Void, failure: @escaping (String) -> Void) {
        let mockedFeedSuccess = FeedResponse(status: "success", data: matches)
        success(mockedFeedSuccess)
    }
}

class MockFeedRepository2: FeedRepositoryProtocol {
    let emptyMatches: [Match] = []
    
    func getFeed(success: @escaping (FeedResponse) -> Void, failure: @escaping (String) -> Void) {
        let mockedFeedEmpty = FeedResponse(status: "success", data: emptyMatches)
        success(mockedFeedEmpty)
    }
}

class MockFeedRepository3: FeedRepositoryProtocol {
    func getFeed(success: @escaping (FeedResponse) -> Void, failure: @escaping (String) -> Void) {
        failure("Error")
    }
}


