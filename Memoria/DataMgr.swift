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

struct Category {
    var name: String?
    var width: CGFloat = 0
}

struct Card {
    var question: String = ""
    var answer: String?
}

class DataMgr {
    
    /// sharedInstance: the DataMgr singleton
    static let sharedInstance = DataMgr()
    
    static let kCardEntityName = "Card"
    static let kCategoryEntityName = "Category"
    
    
    typealias CardMgrCallback = (Card?) -> Void
    typealias CategoryMgrCallback = ([Category?]) -> Void
    typealias FristCategoryMgrCallback = (Category) -> Void
     
     // MARK: - Core Data stack
    
    func fetchCategories(callback: @escaping CategoryMgrCallback) {
        
        var categories:[Category] = []
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        var results:[ECategory]?
        
        do {
            results = try self.managedObjectContext.fetch(request)
            for cat: ECategory in results! {
                let category: Category = Category(name: cat.name, width: 0)
                categories.append(category)
            }
            if categories.count == 0 {
                let info = Category(name: "No cards have been created yet...", width: 0)
                let add = Category(name: "Click + button to add one...", width: 0)
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
                let category: Category = Category(name: cat.name, width: 0)
                categories.append(category)
            }
            if categories.count == 0 {
                let info = Category(name: "Default", width: 0)
                categories.append(info)
            }
            callback(categories)
        }
        catch let error {
            debugPrint("error fetching categories: \(error.localizedDescription)")
            callback(categories)
        }
    }
    
    func fetchFirstCategory(callback: @escaping FristCategoryMgrCallback) {
        
        var category:Category = Category(name: "Default", width: 0)
        let request:NSFetchRequest<ECategory> = ECategory.fetchRequest()
        var results:[ECategory]?
        
        do {
            results = try self.managedObjectContext.fetch(request)
            if results!.count > 0 {
                let cat: ECategory = results!.first!
                category = Category(name: cat.name, width: 0)
            }
            callback(category)
        }
        catch let error {
            debugPrint("error fetching categories: \(error.localizedDescription)")
            callback(category)
        }
    }
     
     /*func saveUser(user: User, callback: @escaping DataMgrCallback) {
     
     var eUser: EUser? = self.getUser()
     
     if eUser == nil {
     eUser = NSEntityDescription.insertNewObject(forEntityName: DataMgr.kUserEntityName, into: self.managedObjectContext) as? EUser
     }
     
     eUser?.email = user.email
     eUser?.name = user.name
     self.saveContext()
     
     callback(eUser)
     }*/
    
    
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
