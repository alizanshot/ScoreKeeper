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
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        newPlayerTextField?.delegate = self
        newPlayerTextField?.returnKeyType = .next
        
        
        hideKeyboardWhenTappedAround()
        tableView?.allowsSelection = false
        
        
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ newPlayerTextField: UITextField) -> Bool {
//        newPlayerTextField.resignFirstResponder()
//        return true
        guard let text = newPlayerTextField.text else {return false}
        
        if text.isEmpty {
            return false
        }
        
        let playerName = newPlayerTextField.text
        guard let name = playerName else {return false}
        
        let newPlayer = Player(name: name, score: 0)
        players.append(newPlayer)
        print(players.count)
        
        tableView.reloadData()
        newPlayerTextField.text? = ""
        return true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newPlayerCell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row].name
        //makes it so that cell isn't highlited when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }

    
    @IBAction func addButtonTapped(_ sender: Any) {
    //adding whatever is in the text field to the table view when the users are deciding who is going to be in the game.
//        guard let text = newPlayerTextField.text else {return}
//
//        if text.isEmpty {
//            return
//        }
//
//        let playerName = newPlayerTextField.text
//        guard let name = playerName else {return}
//
//        let newPlayer = Player(name: name, score: 0)
//        players.append(newPlayer)
//        print(players.count)
//
//        tableView.reloadData()
//        newPlayerTextField.text? = ""
    }
    
    @IBAction func createGame(_ sender: Any) {
        performSegue(withIdentifier: "createGame", sender: players)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createGame" {
            if let destination = segue.destination as? MainGameController{
//                destination.playersInGame = sender as? UITableView
                print("Players are being sent over to Main View Controller: \(players) \(players.count)")
                destination.players = players
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

