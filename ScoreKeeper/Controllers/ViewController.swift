//
//  ViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/23/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newPlayerTextField: UITextField!
    @IBOutlet weak var newGameLabel: UILabel!
    @IBOutlet weak var oldGameLabel: UILabel!
    @IBOutlet weak var playerGroupLabel: UILabel!
    
    var players = [Player](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //allows me to add textfield info to tableview 
        newPlayerTextField?.delegate = self
        newPlayerTextField?.returnKeyType = .done
    
        
        
       // hideKeyboardWhenTappedAround()
        
        tableView?.allowsSelection = false
        newGameLabel?.layer.masksToBounds = true
        newGameLabel?.layer.cornerRadius = 10
        oldGameLabel?.layer.masksToBounds = true
        oldGameLabel?.layer.cornerRadius = 10
        playerGroupLabel?.layer.masksToBounds = true
        playerGroupLabel?.layer.cornerRadius = 10
        
        
    
    }
    
   
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func addPlayersFromTextFieldToTableView(){
        guard let text = newPlayerTextField.text else {return}
        
        if text.isEmpty {
            return
        }
        
        let playerName = newPlayerTextField.text
        guard let name = playerName else {return}
        
        let newPlayer = CoreDataHelper.newPlayer()
        newPlayer.name = name
        newPlayer.score = 0
//        CoreDataHelper.savePlayer()
        
        players.append(newPlayer)
        print(players.count)
        
        
        newPlayerTextField.text? = ""
        
    }
    
    func textFieldShouldReturn(_ newPlayerTextField: UITextField) -> Bool {
       // addPlayersFromTextFieldToTableView()
        self.view.endEditing(true)
        return false
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addPlayersFromTextFieldToTableView()
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newPlayerCell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row].name as? String
        //makes it so that cell isn't highlited when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let playerToRemove = players.remove(at: indexPath.row)
            print(players.count)
            
            let player = players[indexPath.row]
            print("Player: \(player)")
            
            self.players.remove(at: indexPath.row)
     
            print(players.count)
            CoreDataHelper.delete(player: player)
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
           tableView.reloadData()
           
            
        }
    }

    @IBAction func createGame(_ sender: Any) {
    
        let newGame = CoreDataHelper.newGame()
        for player in players {
            //add players to new group
            player.game = newGame
        }
        
        if players.isEmpty {
            let alert = UIAlertController(title: "No Players?", message: "Please Enter Players", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true)
        }
        
//        if newPlayerTextField.text = "" {
//
//
//            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alertGameTitle.addAction(cancelButton)
//
//            self.present(alertGameTitle, animated: true)
//
//        }
        
        
        //TODO: prompt user to add a group?
        let alertCreateAGroup = UIAlertController(title: nil, message: "Would you like to create a reusable group?", preferredStyle: .alert)
        
        let noButton = UIAlertAction(title: "No", style: .default) { (_) in
            CoreDataHelper.save()
            self.performSegue(withIdentifier: "createGame", sender: newGame)
        }
        
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (_) in
            
            
            let alertGroupTitle = UIAlertController(title: "Create a Group", message: "enter the title of this new group", preferredStyle: .alert)
            alertGroupTitle.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "group title"
            })
            let nextButton = UIAlertAction(title: "Next", style: .default, handler: { (_) in
                //create the group
                let newGroup = CoreDataHelper.newGroup(for: newGame)
                newGroup.title = alertGroupTitle.textFields!.first!.text!
                
                CoreDataHelper.save()
                self.performSegue(withIdentifier: "createGame", sender: newGame)
            })
            
            alertGroupTitle.addAction(nextButton)
            self.present(alertGroupTitle, animated: true)
            
        }
        
        alertCreateAGroup.addAction(noButton)
        alertCreateAGroup.addAction(yesButton)
        
        self.present(alertCreateAGroup, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createGame" {
            if let destination = segue.destination as? MainGameController{
//                destination.playersInGame = sender as? UITableView
                destination.currentGame = sender as! Game
                
            }
        }
    }
    
    

}

//call this function in any other view controller and it will dismiss keyboard when tapped anywhere. Thank you stack overflow
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

