//
//  ViewController.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 7/23/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newPlayerTextField: UITextField!
    
    var game: Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton?.layer.cornerRadius = 15
        createButton?.layer.masksToBounds = true
        
        //allows me to add textfield info to tableview 
        newPlayerTextField?.delegate = self
        newPlayerTextField?.returnKeyType = .done
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 12
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToAddPlayers(_ segue: UIStoryboardSegue) {
        
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
        
        game?.playerGroup?.addToPlayersSet(newPlayer)
        
        newPlayerTextField.text? = ""
        
        tableView.reloadData()
    }
    
    
    
    func textFieldShouldReturn(_ newPlayerTextField: UITextField) -> Bool {
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
        //return 1
        if nil == game?.playerGroup {
            return 0
        }
        return game.playerGroup!.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newPlayerCell", for: indexPath)
        //cell.textLabel?.text = ""
        cell.textLabel?.text = game?.playerGroup!.players[indexPath.row].name
        print(indexPath.row)
        cell.textLabel?.font = UIFont(name:"Courier", size:17)
        //makes it so that cell isn't highlited when selected
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            
            let player = game?.playerGroup!.players[indexPath.row]
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            CoreDataHelper.delete(player: player!)
            
            tableView.reloadData()
        }
    }
    
    
    @IBAction func createGame(_ sender: Any) {
        
        if (game.playerGroup?.players.isEmpty)! {
            let alert = UIAlertController(title: "No Players?", message: "Please Enter Players", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true)
        }
        else {
            
            let alertGroupTitle = UIAlertController(title: "Name Your Group", message: "enter the title of this new group", preferredStyle: .alert)
            alertGroupTitle.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "group title"
            })
            let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
                self.game.playerGroup?.title = alertGroupTitle.textFields!.first!.text!
                self.performSegue(withIdentifier: "toMGFromVC", sender: self.game)
            }
            alertGroupTitle.addAction(okButton)
            
            NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using:
                {_ in
                    // Being in this block means that something fired the UITextFieldTextDidChange notification.
                    
                    // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                    let textCount = alertGroupTitle.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines).characters.count ?? 0
                    let textIsNotEmpty = textCount > 0
                    
                    // If the text contains non whitespace characters, enable the OK Button
                    okButton.isEnabled = textIsNotEmpty
                    
            })
            
            self.present(alertGroupTitle, animated: true)
        }
        //self.performSegue(withIdentifier: "toMGFromVC", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainGameController {
            let vc = segue.destination as! MainGameController
            vc.currentGame = game
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

