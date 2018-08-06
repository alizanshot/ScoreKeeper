//
//  TableViewCell.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/26/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var scoreTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scoreTextField.text = "0"
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard var score = Int(scoreTextField.text!) else {
            scoreTextField.text = "1"
            return
            
        }
        score += 1
        scoreTextField.text = String(score)
    }
    
    
    @IBAction func subtractButtonTapped(_ sender: Any) {
        guard var score = Int(scoreTextField.text!) else {
            scoreTextField.text = "-1"
            return
            
        }
        score -= 1
        scoreTextField.text = String(score)
    }
    

    

}
