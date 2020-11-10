//
//  FootballStandingsData.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 15/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit

struct FootballStandingsData: Codable {
    
    var standings:[League]
    
}

struct League: Codable {
    var table:[Teams]
    
}

struct Teams: Codable {
    
    var team:Team
    var position:Int
    var points:Int
}

struct Team: Codable{
    
    var id:Int
    var name:String
    var crestUrl:String
    
}
