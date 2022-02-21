//
//  FeedRequests.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

enum FeedRequest: APIRequest {
    case getFeed
    
    var url: String {
        switch self {
        case .getFeed:
            return "https://feeds.incrowdsports.com/provider/opta/football/v1/matches?compId=3&season=2020"
        }
    }
    
    var headers: JSON {
        switch self {
        case .getFeed:
            return [:]
        }
    }
    
    var parameters: JSON? {
        switch self {
        case .getFeed:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeed:
            return .GET
        }
    }
    
    
}
