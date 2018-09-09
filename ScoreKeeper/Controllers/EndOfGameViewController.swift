//
//  EndOfGameViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/30/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class EndOfGameViewController:  UIViewController {
    
    var playerWithLargestScore: String?
    var secondPlacePlayer: String?
    var playerWithSmallestScrore: String?
    @IBOutlet weak var goHomeButtonLabel: UIButton!
    
    var player: Player?
    
    @IBOutlet weak var winningPlayer: UILabel?
    
    @IBOutlet weak var secondPlaceLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goHomeButtonLabel?.layer.cornerRadius = 15
        goHomeButtonLabel?.layer.masksToBounds = true

        //self.navigationItem.setHidesBackButton(true, animated:true)
        
        //checking that value is not nil and also storing the winningPlayer in a variable to wait for this view controller to load, and then after it loads i use the playerWithLargestScore variable in the MainGameController and pass it into this controller. Basically I couldn't directly pass the data into the winningPlayer label because it hadn't loaded yet
        if let text = playerWithLargestScore {
            winningPlayer?.text = text
            
        }
        
        else {
            winningPlayer?.text = "0"
        }
    }
    
    
    @IBAction func goHomeButtonTapped(_ sender: Any) {
        CoreDataHelper.save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
