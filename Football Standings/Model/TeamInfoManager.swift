//
//  TeamInfoManager.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 28/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit

protocol TeamInfoDelegate {
    func updateMatchDate(date:[TeamMatches])
    func didNotUpdateMatchDate(error:Error)
}

struct TeamInfoManager {
    
    var delegate: TeamInfoDelegate?
    
    
    func finalUrl (teamID:String) {
        let urlString = "https://api.football-data.org/v2/teams/\(teamID)/matches"
        performRequest(url: urlString)
    }
    
    func performRequest(url:String) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.addValue(Constant.apikey, forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let e = error {
                print("There was an error: \(e)")
                return
            } else {
                if let safeData = data {
                    self.parseJSON(data: safeData)
                }
            }
        }
        
        task.resume()
        
    }
    
    func parseJSON(data: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TeamInfoData.self, from: data)
            self.delegate?.updateMatchDate(date: decodedData.matches)
        } catch {
            self.delegate?.didNotUpdateMatchDate(error: error)
        }
        
    }
}
