//
//  PlayerGroupsTableViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/7/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class PlayerGroupsTableViewController: UITableViewController {
    
    var groups = [PlayerGroup]()
    var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        groups = CoreDataHelper.retrieveGroups()
        print(groups)
        print(groups.count)
        // Get players from group like this:
        
//         let players = groups[0].playerGroup

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerGroup", for: indexPath) as! PlayerGroupTableViewCell
//        let group = groups[indexPath.row]
        
        let playerGroupCell = groups[indexPath.row]
        cell.playerGroupLabel.text = playerGroupCell.title
        
      //  cell.textLabel?.text = playerGroupLabel.text
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(group: groups[indexPath.row])
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        row = indexPath.row
//        let playerGroup = groups[indexPath.row]
        
        
        let selectedGroup = groups[indexPath.row]
        let newGame = CoreDataHelper.newGame(from: selectedGroup)
        
        
        let alertGameTitle = UIAlertController(title: "Create a Game", message: "Enter the title of this new game", preferredStyle: .alert)
        alertGameTitle.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "game title"
        })
        let nextButton = UIAlertAction(title: "Start Game", style: .default, handler: { (_) in
            //create the group
            newGame.name = alertGameTitle.textFields!.first!.text!
            
            CoreDataHelper.save()
            self.performSegue(withIdentifier: "toMainGame", sender: newGame)
        })
        
        alertGameTitle.addAction(nextButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertGameTitle.addAction(cancelButton)
        
        self.present(alertGameTitle, animated: true)
        
        
        
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
//        CoreDataHelper.newGame()
//        MainGameController.
//
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMainGame" {
            let destinationVC = segue.destination as! MainGameController
            destinationVC.currentGame = sender as! Game
        }
        
        
        //send selected group to next vc
//         guard let playerGroup = group.playerGroup?.allObjects as? [Player] else { return }
//
//        if segue.identifier == "toMainGame" {
//            let destinationVC = segue.destination as! MainGameController
//            destinationVC.selectedGroup = group
//        }
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
