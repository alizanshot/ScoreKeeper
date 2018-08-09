//
//  OldGameTableViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/3/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit


class OldGameTableViewController: UITableViewController, UITextFieldDelegate{
    
    var recievedSavedGames = [Game]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recievedSavedGames = CoreDataHelper.retrieveGames()
//        tableView.reloadData()
        print("The game is called \(recievedSavedGames)")
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
        return recievedSavedGames.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 80
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldGame", for: indexPath) as! OldGameTableViewCell
        let savedGame = recievedSavedGames[indexPath.row]
        
        cell.oldGameNameLabel.text = savedGame.name
        
        cell.dateLabel.text = savedGame.date?.convertToString()
        
        if cell.oldGameNameLabel.text == "" as String?{
            cell.oldGameNameLabel.text = "No Name"
        }
        
            //recievedSavedGames[indexPath.row].name
    
//        cell.dateLabel.text =
//        let date = OldGameTableViewCell()
//        date.creationDate = Date()
        
       // cell.dateLabel.text = recievedSavedGames[indexPath.row].date
    
    
        // cell.textLabel?.text  = players[indexPath.row].name
        return cell
        
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(game: recievedSavedGames[indexPath.row])
           // CoreDataHelper.delete(game: recievedSavedGames)
            recievedSavedGames.remove(at: indexPath.row)
            
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
