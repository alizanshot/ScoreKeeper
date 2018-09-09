//
//  PlayerGroupsTableViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/7/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class PlayerGroupsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var game: Game?
    var groups = [PlayerGroup]()
    var row = 0

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = CoreDataHelper.retrieveGroups()
        navigationItem.title = "Player Groups"
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Group", style: .plain, target: self, action: #selector(justSegue))

    }
    
    @objc func justSegue(){
        performSegue(withIdentifier: "FromPGtoAP", sender: (Any).self)
    }
    
    @IBAction func unwindToPlayerGroups(_ segue: UIStoryboardSegue) {
        
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
        return groups.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 80
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerGroup", for: indexPath) as! PlayerGroupTableViewCell
        
        let playerGroupCell = groups[indexPath.row]
        cell.playerGroupLabel.text = playerGroupCell.title
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHelper.delete(group: groups[indexPath.row])
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup = groups[indexPath.row]

        game?.playerGroup = selectedGroup
        
        self.performSegue(withIdentifier: "toMainGame", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainGameController {
            let vc = segue.destination as! MainGameController
            vc.currentGame = game
        } else if segue.destination is ViewController {
            let vc = segue.destination as! ViewController
            if game?.playerGroup == nil {
                game?.playerGroup = CoreDataHelper.newGroup()
            }
            vc.game = game
        }
    }

}
