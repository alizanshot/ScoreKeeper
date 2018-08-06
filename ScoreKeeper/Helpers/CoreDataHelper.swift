//
//  CoreDataHelper.swift
//  ScoreKeeper
//
//  Created by Alizandro Lopez on 8/3/18.
//  Copyright © 2018 Alizandro. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    //Game Entity
    static func newGame() -> Game {
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as! Game
        
        return game
    }
    
    static func saveGame() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(game: Game) {
        context.delete(game)
        
        saveGame() 
    }
    
    static func retrieveGames() -> [Game] {
        do {
            let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    
    //Player Entity
    static func newPlayer() -> Player {
        let player = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
        
        return player
    }
    
    static func savePlayer() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(player: Player) {
        context.delete(player)
        
        savePlayer()
    }
    
    static func retrievePlayers() -> [Player] {
        do {
            let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}





