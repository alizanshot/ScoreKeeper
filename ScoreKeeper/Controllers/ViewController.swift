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
    
    var players: [player] = []
    
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
        
        let newPlayer = player(name: name, score: 0)
        players.append(newPlayer)
        print(players.count)
        
        tableView.reloadData()
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
        cell.textLabel?.text = players[indexPath.row].name
        //makes it so that cell isn't highlited when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
            
        }
    }

    @IBAction func createGame(_ sender: Any) {
        performSegue(withIdentifier: "createGame", sender: players)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createGame" {
            if let destination = segue.destination as? MainGameController{
//                destination.playersInGame = sender as? UITableView
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
















//extension UIViewController{
//    func rotate() {
//        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotation.toValue = Double.pi * 2
//        rotation.duration = 0.25 // or however long you want ...
//        rotation.isCumulative = true
//        rotation.repeatCount = Float.greatestFiniteMagnitude
//       
//    }
//}

