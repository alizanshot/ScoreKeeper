//
//  OldGameInfoTableViewCell.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/6/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class OldGameInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var oldPlayerLabel: UILabel!
    @IBOutlet weak var oldScoreLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
