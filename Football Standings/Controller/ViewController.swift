//
//  ViewController.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 15/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pickerSelection: UIPickerView!
    @IBOutlet weak var standingView: UITableView!
    
    var footballStandingsManager = FootballStandingsManager()
    var teamInfoManager = TeamInfoManager()
    var teamInfoVC = TeamInfoVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSelection.delegate = self
        pickerSelection.dataSource = self
        standingView.dataSource = self
        standingView.delegate = self
        footballStandingsManager.delegate = self
        teamInfoManager.delegate = self
        
        footballStandingsManager.performRequest(url: Constant.loadUrl)
        
    }

    
    var teamArray:[Teams] = []
    var positionID:[Int:Int] = [:]
    var teamMatches:[TeamMatches] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.teamViewSegueId {
            let destinationVC = segue.destination as! TeamInfoVC
            destinationVC.matchDate = teamMatches
        }
    }

}

//MARK: - Football League Selector

extension ViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return footballStandingsManager.footballLeagues.count
    }
}

extension ViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        footballStandingsManager.footballLeagueDisplay[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let leagueSelect = footballStandingsManager.footballLeagues[row]
        footballStandingsManager.finalUrl(leagueSelect)
    }
}

//MARK: - Updates League Table

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = standingView.dequeueReusableCell(withIdentifier: Constant.standingCellId) as! FootballTeamViewController
        cell.teamName.text = teamArray[indexPath.row].team.name
        cell.standingNumberText.text = String(teamArray[indexPath.row].position)
        cell.formLabel.text = String(teamArray[indexPath.row].points)
        cell.StandingNumberImage.setImage(URL(string: teamArray[indexPath.row].team.crestUrl), placeholder: nil)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView
        cell.layer.cornerRadius = cell.frame.size.height / 5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
}

//MARK: - Calls API To Get Specific Matches From The Team Selected In The TableView

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        positionID = [teamArray[indexPath.row].position:teamArray[indexPath.row].team.id]
        for position in positionID {
                teamInfoManager.finalUrl(teamID: String(position.value))
            }
    }
}

//MARK: - Delegate Implementations

extension ViewController: FootballStandingsDelegate{
    
    func didUpdateStandings(data: [Teams]) {
        DispatchQueue.main.async{
            self.teamArray = data
            self.standingView.reloadData()
        }
    }
        
    func didNotUpdateStandings(error: Error) {
        print(error)
    }
    
    
}

extension ViewController : TeamInfoDelegate {
    
    func updateMatchDate(date:[TeamMatches]) {
        DispatchQueue.main.async {
            self.teamMatches = date
            self.performSegue(withIdentifier: Constant.teamViewSegueId, sender: self)
        
        }
    }
    
    func didNotUpdateMatchDate(error: Error) {
        print("There was an error: \(error)")
    }
    
    
}


