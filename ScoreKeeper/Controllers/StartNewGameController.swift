//
//  StartNewGameController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/1/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class StartNewGameController: UIViewController {
    
    var savedGames: [String] = []
    
    //  @IBOutlet weak var noGameNameLabel: UILabel!
    @IBOutlet weak var nameOfGameTextField: UITextField!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        startGameButton.layer.masksToBounds = true
        startGameButton.layer.cornerRadius = 15
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startGameButtonTapped(_ sender: Any) {
        //savedGames.append(nameOfGameTextField.text!)
       
        
        if nameOfGameTextField.text != ""{
            AudioServicesPlayAlertSound(SystemSoundID(1326))
            let newGame = CoreDataHelper.newGame()
            newGame.name = nameOfGameTextField.text!
            
            newGame.date = Date()
            
            CoreDataHelper.saveGame()
        }
        else if savedGames.isEmpty{
            
            let newGame = CoreDataHelper.newGame()
            newGame.name = "No Name"
            newGame.date = Date()
            
            CoreDataHelper.save()
            
//            let alertGameTitle = UIAlertController(title: "No Name?", message: "Please enter a name for this game.", preferredStyle: .alert)
//            
//            alertGameTitle.addTextField(configurationHandler: { (textField) in
//                textField.placeholder = "Game Title"
////                let newGame = CoreDataHelper.newGame()
////                newGame.name = textField.text
////                newGame.date = Date()
////                
////                CoreDataHelper.saveGame()
//            })
//            
//            
//            let okButton = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
//                
//                
//                
//            })
//            
//            alertGameTitle.addAction(okButton)
//            self.present(alertGameTitle, animated: true, completion: nil)
//            
//            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertGameTitle.addAction(okButton)
//
//            self.present(alertGameTitle, animated: true)
//
//            let newGame = CoreDataHelper.newGame()
//            newGame.name = nameOfGameTextField.text!
//
//            newGame.date = Date()
//
//            CoreDataHelper.saveGame()
            
        }
        

        
    
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






