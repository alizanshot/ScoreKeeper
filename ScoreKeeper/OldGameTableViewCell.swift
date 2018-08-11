//
//  OldGameTableViewCell.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/6/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class OldGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var oldGameNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var creationDate = Date()
    
        override func awakeFromNib() {
            super.awakeFromNib()
    
            // Initialization code
        }
    var oldWinner: String?
    
    @IBOutlet weak var recievedOldWinner: UILabel!
    
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

        // Configure the view for the selected state
        
        if let text = oldWinner {
            recievedOldWinner?.text = text
            
        } else {
            recievedOldWinner?.text = "0"
        }
    }
    
    

}
