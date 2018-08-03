//
//  MainGameController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/25/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class MainGameController: UITableViewController {

    @IBOutlet var playersInGame: UITableView!
    var playerName = ""
    var losingPlayer = ""
    var tiedPlayers: [String] = []
    
    var players = [Player]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var playersInGame = players
        print(players.count)
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        navigationItem.title = "Game Name"

        hideKeyboardWhenTappedAround()
        
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerInGameCell", for: indexPath)
        cell.textLabel?.text  = players[indexPath.row].name
       // cell.textLabel?.text = players[indexPath.row].name
        //makes is so that cell isn't highlighted when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
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
            if let destination = segue.destination as? EndOfGameViewController{
                destination.playerWithLargestScore = playerName
                
            }
            if let destination2 = segue.destination as? EndOfGameViewController{
                destination2.playerWithSmallestScrore = losingPlayer
            }
        }
        
    
        // Print the high scoring player here
        print(playerName)
        print(losingPlayer)
    }
    

}
