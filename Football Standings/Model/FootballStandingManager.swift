//
//  FootballStandingManager.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 15/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit

protocol FootballStandingsDelegate {
    func didUpdateStandings(data: [Teams])
    func didNotUpdateStandings(error: Error)
}

struct FootballStandingsManager {
    
    
    var delegate: FootballStandingsDelegate?
    
    var footballLeagueDisplay = ["Premier League", "Bundesliga", "Serie A", "La Liga", "France Ligue 1"]
    
    var footballLeagues = ["PL", "BL1", "SA", "PD", "FL1"]
    var baseUrl = "https://api.football-data.org/v2/competitions"
    
    
    func finalUrl(_ league:String){
        let urlString = "\(baseUrl)/\(league)/standings"
        performRequest(url: urlString)
    }
    
    func performRequest(url: String){
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue(Constant.apikey, forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            self.parseJSON(data)
            
        }
        
        task.resume()
        
    }
    
    
    func parseJSON (_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FootballStandingsData.self, from: data)
            self.delegate?.didUpdateStandings(data: decodedData.standings[0].table)
        }
        catch {
            self.delegate?.didNotUpdateStandings(error: error)
        }
        
    }
}
