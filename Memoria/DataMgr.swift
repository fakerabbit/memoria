//
//  DataMgr.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 1/8/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import UserNotifications

struct Category {
    var name: String?
    var width: CGFloat = 0
    var active: Bool = true
}

struct Card {
    var id: String = ""
    var question: String = ""
    var answer: String?
    var category: String?
    var active: Bool = true
    var tries: Int = 0
}

enum Difficulty:Int {
    case easy = 1, good, hard
}

class DataMgr {
    
    /// sharedInstance: the DataMgr singleton
    static let sharedInstance = DataMgr()
    
    static let kCardEntityName = "Card"
    static let kCategoryEntityName = "Category"
    
    typealias CardMgrCallback = (Card?) -> Void
    typealias CategoryMgrCallback = ([Category?]) -> Void
    typealias FristCategoryMgrCallback = (Category) -> Void
    typealias CardsMgrCallback = ([Card?]) -> Void
    
    // MARK:- Game Operations
    
    func evaluateCard(card: Card, difficulty: Int, testCards: [Card?], callback: CardsMgrCallback) {
        
        var updatedCards:[Card?] = []
        
        for i in 0 ..< testCards.count {
            let c:Card = testCards[i]!
            if c.id != card.id {
                updatedCards.append(c)
            }
        }
        
        if card.active == true {
            programCard(card: card, difficulty: difficulty)
        }
        
        callback(updatedCards)
    }
    
    func programCard(card: Card, difficulty: Int) {
        
        let center = UNUserNotificationCenter.current()
        let identifier = "UYLLocalNotification"
        
        var date = Date()
        switch difficulty {
        case Difficulty.easy.rawValue:
            date = date.addingTimeInterval(240)
            break
        case Difficulty.good.rawValue:
            date = date.addingTimeInterval(600)
            break
        case Difficulty.hard.rawValue:
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            break
        default:
            date = date.addingTimeInterval(60)
        }
        var triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        triggerDate.timeZone = TimeZone.current
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = card.category!
        content.body = card.question
        content.badge = 1
        content.sound = UNNotificationSound.default()
        content.userInfo = Dictionary(dictionaryLiteral: ("cardId", card.id))
        content.categoryIdentifier = "UYLReminderCategory"
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: { error in
            if error != nil {
                // Something went wrong
                debugPrint("error adding notification to center")
            }
        })
    }
    
    // MARK:- Data Operations
    
    func fetchCategories(callback: @escaping CategoryMgrCallback) {
        
        var categories:[Category] = []
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        var results:[ECategory]?
        
        do {
            results = try self.managedObjectContext.fetch(request)
            for cat: ECategory in results! {
                let category: Category = Category(name: cat.name, width: 0, active: cat.active)
                categories.append(category)
            }
            if categories.count == 0 {
                let info = Category(name: "No cards have been created yet...", width: 0, active: false)
                let add = Category(name: "Click + button to add one...", width: 0, active: false)
                categories.append(info)
                categories.append(add)
            }
            callback(categories)
        }
        catch let error {
            debugPrint("error fetching categories: \(error.localizedDescription)")
            callback(categories)
        }
    }
    
    func fetchCreateCategories(callback: @escaping CategoryMgrCallback) {
        
        var categories:[Category] = []
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        var results:[ECategory]?
        
        do {
            results = try self.managedObjectContext.fetch(request)
            for cat: ECategory in results! {
                let category: Category = Category(name: cat.name, width: 0, active: cat.active)
                categories.append(category)
            }
            if categories.count == 0 {
                let info = Category(name: "Default", width: 0, active: true)
                categories.append(info)
            }
            callback(categories)
        }
        catch let error {
            debugPrint("error fetching create categories: \(error.localizedDescription)")
            callback(categories)
        }
    }
    
    func fetchFirstCategory(callback: @escaping FristCategoryMgrCallback) {
        
        var category:Category = Category(name: "Default", width: 0, active: true)
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        var results:[ECategory]?
        
        do {
            results = try self.managedObjectContext.fetch(request)
            if results!.count > 0 {
                let cat: ECategory = results!.first!
                category = Category(name: cat.name, width: 0, active: cat.active)
            }
            callback(category)
        }
        catch let error {
            debugPrint("error fetching first category: \(error.localizedDescription)")
            callback(category)
        }
    }
    
    func saveCategory(category: Category, callback: @escaping FristCategoryMgrCallback) {
        
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", category.name!)
        var results:[ECategory]?
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            if results!.count == 0 {
                let newCat:ECategory = (NSEntityDescription.insertNewObject(forEntityName: DataMgr.kCategoryEntityName, into: self.managedObjectContext) as? ECategory)!
                newCat.name = category.name
                newCat.id = NSUUID().uuidString
                newCat.active = true
                self.saveContext()
            }
            callback(category)
        }
        catch let error {
            debugPrint("error saving category: \(error.localizedDescription)")
            callback(category)
        }
    }
    
    func saveCard(card: Card, callback: @escaping CardMgrCallback) {
        let newCard:ECard = NSEntityDescription.insertNewObject(forEntityName: DataMgr.kCardEntityName, into: self.managedObjectContext) as! ECard
        newCard.id = NSUUID().uuidString
        newCard.active = true
        newCard.question = card.question
        newCard.answer = card.answer
        newCard.type = 0
        
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", card.category!)
        var results:[ECategory]?
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            if results!.count > 0 {
                let cat: ECategory = results!.first!
                newCard.category = cat
                self.saveContext()
                callback(card)
            }
            else {
                callback(nil)
            }
        }
        catch let error {
            debugPrint("error saving card: \(error.localizedDescription)")
            callback(nil)
        }
        
        self.saveContext()
    }
    
    func getCardsForCategory(category: Category, callback: @escaping CardsMgrCallback) {
        
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", category.name!)
        var results:[ECategory]?
        var cards: [Card?] = []
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            for cat: ECategory in results! {
                let cardArray:[ECard] = cat.cards?.allObjects as! [ECard]
                for card: ECard in cardArray {
                    //debugPrint("card for cat: \(card.active)")
                    let c = Card(id: card.id!,question: card.question!, answer: card.answer, category: cat.name, active: card.active, tries: 0)
                    cards.append(c)
                }
            }
        }
        catch let error {
            debugPrint("error fetching cards: \(error.localizedDescription)")
        }
        callback(cards)
    }
    
    func updateCardStatusForCategory(category: String, active: Bool, callback: @escaping CardsMgrCallback) {
        
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", category)
        var results:[ECategory]?
        var cards: [Card?] = []
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            for cat: ECategory in results! {
                let cardArray:[ECard] = cat.cards?.allObjects as! [ECard]
                for card: ECard in cardArray {
                    card.active = active
                    let c = Card(id: card.id!,question: card.question!, answer: card.answer, category: cat.name, active: card.active, tries: 0)
                    cards.append(c)
                }
            }
        }
        catch let error {
            debugPrint("error updating card status for category: \(error.localizedDescription)")
        }
        self.saveContext()
        callback(cards)
    }
    
    func updateCardStatus(cardId: String, active: Bool, callback: @escaping CardMgrCallback) {
        
        let request:NSFetchRequest<ECard> = ECard.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", cardId)
        var results:[ECard]?
        var card: Card?
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            
            if (results?.count)! > 0 {
                let c:ECard = (results?.first)!
                c.active = active
                card = Card(id: c.id!, question: c.question!, answer: c.answer, category: c.category?.name, active: c.active, tries: 0)
                //debugPrint("updated card: \(c)")
            }
        }
        catch let error {
            debugPrint("error updating card status: \(error.localizedDescription)")
        }
        self.saveContext()
        callback(card)
    }
    
    func updateCard(card: Card, callback: @escaping CardMgrCallback) {
        
        let request:NSFetchRequest<ECard> = ECard.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", card.id)
        var results:[ECard]?
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            
            if (results?.count)! > 0 {
                let c:ECard = (results?.first)!
                c.question = card.question
                c.answer = card.answer
                c.active = card.active
                
                let requestCat:NSFetchRequest<ECategory> = ECategory.fetchRequest()
                let predicateCat = NSPredicate(format: "name == %@", card.category!)
                var resultsCat:[ECategory]?
                requestCat.predicate = predicateCat
                
                resultsCat = try self.managedObjectContext.fetch(requestCat)
                if resultsCat!.count > 0 {
                    let cat: ECategory = resultsCat!.first!
                    c.category = cat
                    debugPrint("updated card: \(c)")
                }
                else {
                    callback(nil)
                }
            }
        }
        catch let error {
            debugPrint("error updating card: \(error.localizedDescription)")
        }
        self.saveContext()
        callback(card)
    }
    
    func fetchCard(for cardId: String, callback: @escaping CardMgrCallback) {
        
        var card:Card?
        let request:NSFetchRequest<ECard> = ECard.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", cardId)
        var results:[ECard]?
        request.predicate = predicate
        
        do {
            results = try self.managedObjectContext.fetch(request)
            
            if (results?.count)! > 0 {
                let c:ECard = (results?.first)!
                card = Card(id: cardId, question: c.question!, answer: c.answer, category: c.category?.name, active: c.active, tries: 0)
            }
        }
        catch let error {
            debugPrint("error fetching card: \(error.localizedDescription)")
        }
        
        callback(card)
    }
    
    // MARK: - Core Data stack
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Memoria")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
