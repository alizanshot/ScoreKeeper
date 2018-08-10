//
//  MainGameController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/25/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class MainGameController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet var playersInGame: UITableView!
    var playerName = ""
    var losingPlayer = ""
    var tiedPlayers: [String] = []
    
    var currentGame: Game!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
        navigationItem.title = "Game Name"
        tableView.dataSource = self
        tableView.delegate = self

        hideKeyboardWhenTappedAround()
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentGame.players.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 90
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerInGameCell", for: indexPath)
        
        let player = currentGame.players[indexPath.row]
        cell.textLabel?.text  = player.name
       // cell.textLabel?.text = players[indexPath.row].name
        //makes is so that cell isn't highlighted when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playerToRemove = currentGame.players[indexPath.row]
            CoreDataHelper.delete(player: playerToRemove)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }


    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var largestScore = 0
       // var smallestScore = 0
        //var playerName = ""
        //for loop is to check which cell contains the highest score and set playerName to the person in that cell
        
        let players = currentGame.players
        
        for index in 0..<players.count{
            let cell = playersInGame.cellForRow(at: IndexPath(row: index, section: 0)) as! TableViewCell
            
            let score = Int(cell.scoreTextField.text ?? "0")!
         
    
            
            if score > largestScore{
                largestScore = score
                playerName = ((cell.textLabel?.text)! + " is the winner!")
            }
//            else if score < largestScore{
//                smallestScore = score
//
//                losingPlayer = ((cell.textLabel?.text)! + " is the loser")
//
//            }
            else if score == largestScore{
                playerName = "There is a tie!"
            }
           
            
            
        }
        print(tiedPlayers)
        //transfering winningPlayer to EndOfGameViewController to be displayed
        if segue.identifier == "endGame"{
            AudioServicesPlayAlertSound(SystemSoundID(1335))
            if let destination = segue.destination as? EndOfGameViewController{
                destination.playerWithLargestScore = playerName
                
            }
//            else if let destination2 = segue.destination as? EndOfGameViewController{
//                destination2.playerWithSmallestScrore = losingPlayer
//            }
        }
        

        // Print the high scoring player here
        print(playerName)
        //print(losingPlayer)
        
        
    }

    
    

}






