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
    
    @IBOutlet weak var playersInGameTableView: UITableView!
    
    var currentGame: Game!
    var winningPlayer: Player!
    var winning_message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        navigationItem.title = "Game Name"
        playersInGameTableView.dataSource = self
        playersInGameTableView.delegate = self

        hideKeyboardWhenTappedAround()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func findWinner() {
        var largestScore = Int.min
        
        let players = currentGame.playerGroup!.players
        var p: Player
        
        for index in 0..<players.count{
            let cell = playersInGameTableView?.cellForRow(at: IndexPath(row: index, section: 0)) as! TableViewCell
            
            // get score value from text field
            let score = Int(cell.scoreTextField.text ?? "0")!
            
            // get the current player associated with that score
            p = players[index]
            
            // now that we are scoring create a new score to store in DB
            let newScore  = CoreDataHelper.newScore()
            newScore.score = Int32(score)
            newScore.game_date = currentGame.date
            p.scores?.adding(newScore)
            
            if score > largestScore{
                largestScore = score
                winningPlayer = p
                winning_message = winningPlayer.name! + " is the winner"
            }
            else if score == largestScore{
                largestScore = score
                winning_message = "There is a Tie!"
            }
        }
        currentGame.winner = winningPlayer.name
        print("the winning msg be " + winning_message)
    }
    

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentGame.playerGroup!.players.count
    
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 90
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerInGameCell", for: indexPath)
        
        let player = currentGame.playerGroup!.players[indexPath.row]
        cell.textLabel?.text  = player.name
        // cell.textLabel?.text = players[indexPath.row].name
        //makes is so that cell isn't highlighted when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playerToRemove = currentGame.playerGroup!.players[indexPath.row]
            CoreDataHelper.delete(player: playerToRemove)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.destination is EndOfGameViewController {
            let vc = segue.destination as! EndOfGameViewController
            vc.playerWithLargestScore = winning_message
        }
    }
    
    
    @IBAction func endGameButtonTapped(_ sender: Any) {
        findWinner()
        AudioServicesPlayAlertSound(SystemSoundID(1332))
        
        //1321
        
    
    }
    
}





