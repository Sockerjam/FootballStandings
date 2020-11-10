//
//  TeamInfoVC.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 28/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit
import SVGWebRenderer

class TeamInfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backToLeaguesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backToLeaguesButton.layer.cornerRadius = backToLeaguesButton.frame.size.height / 5
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: Constant.teamInfoCell, bundle: nil), forCellReuseIdentifier: Constant.reusableCell)
        
        
    }
    
    var matchDate:[TeamMatches] = []
    
    //MARK: - String Formatting For Match Dates
    
    func format(_ date:String) -> String {
        var formattedMatchDate:String = ""
        let index = date.firstIndex(of: "T") ?? date.endIndex
        let formattedDate = date[..<index]
        formattedMatchDate.append(String(formattedDate))
        
        return formattedMatchDate
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

//MARK: - Updating Tableview Layout For Specific Team

extension TeamInfoVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reusableCell) as! TeamInfoCell
        cell.dateLabel.text = format(matchDate[indexPath.row].utcDate)
        cell.topImageView.setImage(URL(string: "https://crests.football-data.org/\(matchDate[indexPath.row].homeTeam.id).svg"), placeholder: nil)
        cell.bottomImageView.setImage(URL(string: "https://crests.football-data.org/\(matchDate[indexPath.row].awayTeam.id).svg"), placeholder: nil)
        
        cell.homeTeamName.text = matchDate[indexPath.row].homeTeam.name
        cell.awayTeamName.text = matchDate[indexPath.row].awayTeam.name
        
        if let homeScore = matchDate[indexPath.row].score.fullTime.homeTeam, let awayScore = matchDate[indexPath.row].score.fullTime.awayTeam  {
            cell.homeScore.text = String(homeScore)
            cell.awayScore.text = String(awayScore)
        } else {
            cell.homeScore.text = "-"
            cell.awayScore.text = "-"
        }
        
        
        return cell
    }
    
}

extension TeamInfoVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
