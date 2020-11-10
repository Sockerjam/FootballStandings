//
//  FootballTeamViewController.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 15/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit
import SVGWebRenderer

class FootballTeamViewController: UITableViewCell {
    
    
    @IBOutlet weak var StandingNumberImage: UIImageView!
    @IBOutlet weak var standingNumberText: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var formLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        formLabel.adjustsFontSizeToFitWidth = true
        standingNumberText.adjustsFontSizeToFitWidth = true
    }
    
}
