//
//  StartNewGameController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/1/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class StartNewGameController: UIViewController {
    
    var savedGames: [String] = []

  //  @IBOutlet weak var noGameNameLabel: UILabel!
    @IBOutlet weak var nameOfGameTextField: UITextField!

    
    @IBOutlet weak var startGameButtonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        startGameButtonLabel.layer.masksToBounds = true
        startGameButtonLabel.layer.cornerRadius = 10
        
        
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startGameButtonTapped(_ sender: Any) {
        //savedGames.append(nameOfGameTextField.text!)
        
        let newGame = CoreDataHelper.newGame()
        newGame.name = nameOfGameTextField.text!
        newGame.date = Date()
    
        CoreDataHelper.saveGame()
        //print(savedGames)
    

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "startGame"{
//            savedGames.append(nameOfGameTextField.text!)
//            if let destination = segue.destination as? OldGameTableViewController{
////                destination.recievedSavedGames = savedGames
//                print(savedGames)
//            }
//        }
//        
//    }


}






