//
//  FeedRepositoryTests.swift
//  FootballAppTests
//
//  Created by Mehmed on 2/21/22.
//

import XCTest

class FeedRepositoryTests: XCTestCase {

    func testGettingFeedSuccess() throws {
        let apiClient = MockApiProtocol1()
        let repository = FeedRepository(apiClient: apiClient)
        let expectation = XCTestExpectation(description: "Feed fetched")
        
        repository.getFeed { response in
            XCTAssertEqual(response.data, apiClient.matches)
            expectation.fulfill()
        } failure: { _ in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGettingFeedFailure() throws {
        let apiClient = MockApiProtocol2()
        let repository = FeedRepository(apiClient: apiClient)
        let expectation = XCTestExpectation(description: "Feed fetched")
        
        repository.getFeed { _ in
            XCTFail()
        } failure: { error in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

}

class MockApiProtocol1: APIProtocol {
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
    
    func makeRequest<R>(_ request: APIRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ()) where R : Decodable {
        let mockedFeedSuccess = FeedResponse(status: "success", data: matches)
        let encoder = JSONEncoder()
        let encodedTeam = try? encoder.encode(mockedFeedSuccess)
    
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(R.self, from: encodedTeam ?? Data())
            DispatchQueue.main.async {
                success(object)
            }
        } catch (let error) {
            print(error)
        }
    }
}

class MockApiProtocol2: APIProtocol {
    func makeRequest<R>(_ request: APIRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ()) where R : Decodable {
        failure("error")
    }
}
