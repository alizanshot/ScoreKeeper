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
        print(game)
        return game
    }
    
    static func newGame(from group: PlayerGroup) -> Game {
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as! Game
        
        group.games?.adding(game)
        
        return game
    }
    
    static func delete(game: Game) {
        context.delete(game)
        
        save()
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
    
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(player: Player) {
        context.delete(player)
        
        save()
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
    
    
    //playeGroup Entity
    static func newGroup() -> PlayerGroup {
        let playerGroup = NSEntityDescription.insertNewObject(forEntityName: "PlayerGroup", into: context) as! PlayerGroup
    
        return playerGroup
    }
    
    static func delete(group: PlayerGroup) {
        context.delete(group)
        save()
    }
    
    
    static func retrieveGroups() -> [PlayerGroup] {
        do {
            let fetchRequest = NSFetchRequest<PlayerGroup>(entityName: "PlayerGroup")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    
    //Score Entity
    static func newScore() -> Score {
        let score = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        
        return score
    }

    static func delete(score: Score) {
        context.delete(score)
        
        save()
    }
    
    
    static func retrieveScores() -> [Score] {
        do {
            let fetchRequest = NSFetchRequest<Score>(entityName: "Score")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
}

extension PlayerGroup {
    var players: [Player] {
        guard let players = self.playersSet else {
            return []
        }
        
        return players.array as! [Player]
    }
}

extension Player {
    var scores_ar: [Score] {
        guard let scores_ar = self.scores else {
            return []
        }
        
        return scores_ar.allObjects as! [Score]
    }
}

