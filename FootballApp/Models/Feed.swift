//
//  Feed.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

struct FeedResponse: Decodable {
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
    let venue: Venue
    
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
                    return .playing
                } else {
                    return .completed
                }
            } else {
                // Not started yed
                return .willBePlayed
            }
        }
        
        //Will be played
        if currentDate < formattedDate {
            return .willBePlayed
        }
        
        //Completed
        return .completed
    }
    
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

enum MatchStatus {
    case completed
    case playing
    case willBePlayed
}
