//
//  Feed.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

struct FeedResponse: Codable {
    let status: String
    let data: [Match]
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

struct Match: Codable {
    let id: String
    let feedMatchId: Int
    let competition: String
    let period: String
    let minute: Int
    let date: String
    let homeTeam: Team
    let awayTeam: Team
    let venue: Venue
    
    enum CodingKeys: String, CodingKey {
        case id
        case feedMatchId
        case competition
        case period
        case minute
        case date
        case homeTeam
        case awayTeam
        case venue
    }
    
    var formattedDate: Date {
        let formatter = DateFormatter.iso8601Formater
        if let decodedDate = formatter.date(from: date) {
            return decodedDate
        } else {
            return Date()
        }
    }
    
    var status: MatchStatus {
        let currentDate = Date()
        let differenceBetweenDates = currentDate.days(from: formattedDate)
        
        //Playing today
        if differenceBetweenDates == 0 {
            let differenceInHours = currentDate.hours(from: formattedDate)
            
            // Started playing or completed
            if currentDate > formattedDate {
                if differenceInHours <= 2 {
                    return .live
                } else {
                    return .previous
                }
            } else {
                // Not started yed
                return .next
            }
        }
        
        //Will be played
        if currentDate < formattedDate {
            return .next
        }
        
        //Completed
        return .previous
    }
    
}

struct Team: Codable {
    let id: String
    let name: String
    let score: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case score
    }
}

struct Venue: Codable {
    let id: Int
    let name: String
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
    }
}

enum MatchStatus {
    case previous
    case live
    case next
}


extension Match: Equatable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
    
}
