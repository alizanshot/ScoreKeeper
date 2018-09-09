//
//  InitialViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/17/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton?.layer.cornerRadius = 15
        newGameButton?.clipsToBounds = true
        historyButton?.layer.cornerRadius = 15
        historyButton?.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGameButtonTapped(_ sender: Any) {
        game = CoreDataHelper.newGame()
        game?.name = game?.date?.convertToString()
        game?.date = Date()
        CoreDataHelper.save()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PlayerGroupsTableViewController
        {
            let vc = segue.destination as? PlayerGroupsTableViewController
            vc?.game = game
        }
    }
 
}
