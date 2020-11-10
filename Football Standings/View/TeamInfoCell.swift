//
//  TeamInfoCell.swift
//  Football Standings
//
//  Created by Niclas Jeppsson on 28/10/2020.
//  Copyright © 2020 Niclas Jeppsson. All rights reserved.
//

import UIKit
import SVGWebRenderer

class TeamInfoCell: UITableViewCell {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
