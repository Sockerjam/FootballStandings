//
//  TeamInfoData.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 28/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit


struct TeamInfoData : Codable {
    
    var matches:[TeamMatches]
    
}

struct TeamMatches : Codable {
    
    var utcDate:String
    var homeTeam:HomeTeam
    var awayTeam:AwayTeam
    var score:Score
    
}
struct HomeTeam : Codable {
    
    var id:Int
    var name:String
}

struct AwayTeam : Codable {
    
    var id:Int
    var name:String
}

struct Score : Codable {
    
    var fullTime:FullTime
}

struct FullTime : Codable {
    
    var homeTeam:Int?
    var awayTeam:Int?
}
