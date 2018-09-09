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

class StartNewGameController: UIViewController, UITextFieldDelegate {
    
    var savedGames: [String] = []
    
    //  @IBOutlet weak var noGameNameLabel: UILabel!
    @IBOutlet weak var nameOfGameTextField: UITextField!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        nameOfGameTextField.delegate = self
        startGameButton.layer.masksToBounds = true
        startGameButton.layer.cornerRadius = 15
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 75
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    
    @IBAction func unwindToStartGame(_ segue: UIStoryboardSegue) {
        
    }
    
//    @IBAction func startGameButtonTapped(_ sender: Any) {
//        //savedGames.append(nameOfGameTextField.text!)
//        
//        
//        if nameOfGameTextField.text != ""{
//            let newGame = CoreDataHelper.newGame()
//            newGame.name = nameOfGameTextField.text!
//            
//            newGame.date = Date()
//            
//            CoreDataHelper.save()
//        }
//        else if savedGames.isEmpty{
//            
//            
//            
//            //            alertGameTitle.addTextField(configurationHandler: { (textField) in
//            //                textField.placeholder = "Game Title"
//            ////                let newGame = CoreDataHelper.newGame()
//            ////                newGame.name = textField.text
//            ////                newGame.date = Date()
//            ////
//            ////                CoreDataHelper.saveGame()
//            //            })
//            
//            //
//            //            let okButton = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
//            //
//            //                let newGame = CoreDataHelper.newGame()
//            //                newGame.name = alertGameTitle.textFields!.first!.text!
//            //                newGame.date = Date()
//            //
//            //                CoreDataHelper.save()
//            //
//            //            })
//            
//            //            alertGameTitle.addAction(okButton)
//            //            self.present(alertGameTitle, animated: true, completion: nil)
//            
//            //            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            //            alertGameTitle.addAction(okButton)
//            //
//            //            self.present(alertGameTitle, animated: true)
//            //
//            //            let newGame = CoreDataHelper.newGame()
//            //            newGame.name = nameOfGameTextField.text!
//            //
//            //            newGame.date = Date()
//            //
//            //            CoreDataHelper.saveGame()
//            
//        }
//        
//        
//        
//        
//        //print(savedGames)
//        
//        
//    }
    
    
    
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






