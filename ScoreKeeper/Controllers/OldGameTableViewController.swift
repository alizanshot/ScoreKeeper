//
//  OldGameTableViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/3/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit


class OldGameTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recievedSavedGames = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.allowsSelection = false
        recievedSavedGames = CoreDataHelper.retrieveGames()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recievedSavedGames.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 80
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldGame", for: indexPath) as! OldGameTableViewCell
        let savedGame = recievedSavedGames[indexPath.row]
        
        
        cell.oldWinner.text = savedGame.winner
        cell.dateLabel.text = savedGame.date?.convertToString()

        
        //recievedSavedGames.sort(by: {($0.date?.timeIntervalSinceNow)! < ($1.date?.timeIntervalSinceNow)!})
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Game                                                        Winner"
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(game: recievedSavedGames[indexPath.row])
            recievedSavedGames = CoreDataHelper.retrieveGames()
            tableView.reloadData()
            
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
