//
//  Feed.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

struct Feed: Decodable {
    let status: String
    let data: [Match]
}

struct Match: Decodable {
    let id: String
    let feedMatchId: Int
    let competition: String
    let period: String
    let minute: Int
    let date: String
    let homeTeam: Team
    let awayTeam: Team
}

struct Team: Decodable {
    let id: String
    let name: String
    let score: Int
}

struct Venue: Decodable {
    let id: Int
    let name: String
    let location: String
}
