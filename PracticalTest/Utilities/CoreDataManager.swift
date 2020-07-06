//
//  CoreDataManager.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "PracticalTest")
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
    
    
    
    
    public func fetchData(entity:String, updatePridicate: String?, completion:(Bool, [NSManagedObject], Error?)->()) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        // A Boolean value that indicates whether the objects resulting from a fetch request are faults.
        request.returnsObjectsAsFaults = false
        
        if let updatePridicate = updatePridicate {
            request.predicate = NSPredicate(format: updatePridicate)
        }
        do {
            let result = try self.persistentContainer.viewContext.fetch(request)
            completion(true, result as! [NSManagedObject], nil)
        } catch {
            print("Failed")
            completion(false, [], error)
        }
    }
    
}


extension CoreDataManager {
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
