//
//  DBHelper.swift
//  MoviesTonight
//
//  Created by Pawan on 19/09/18.
//  Copyright © 2018 Pawan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum DBHelper {
    
    static func addQueryToDB(withText text:String, completion: (Bool) -> ()) {
       
        DispatchQueue.main.sync {
            
            let alreadyCachedQueries = getCachedQueriesFromDB(withAscendingSorting: true)
            
            //If it is already present, delete the3 old entry and then add a new entry.
            if alreadyCachedQueries?.contains(text) ?? false {
                removeQueryFromDB(withText: text)
            }
            
            //If count of cached queries is equal to 10, then first removed the oldest query string and then will add a new entry to DB.
            if alreadyCachedQueries?.count == 10 && alreadyCachedQueries?.first != nil {
                removeQueryFromDB(withText: (alreadyCachedQueries?.first)!)
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Queries", in: context)
            let query = NSManagedObject(entity: entity!, insertInto: context) as? Queries
            
            //Adding query to DB with current Date ande query string
            query?.timestamp = Date()
            query?.query = text
            
            do {
                try context.save()
                completion(true)
            } catch {
                completion(false)
            }
        }
        
    }
    
    static func getCachedQueriesFromDB(withAscendingSorting needSorting:Bool) -> [String]? {
        var queries:[Queries]?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Fetching all the queries present in the DB.
        let fetchRequest = NSFetchRequest<Queries>(entityName: "Queries")
        
        let sort = NSSortDescriptor(key: #keyPath(Queries.timestamp), ascending: needSorting)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            queries = try context.fetch(fetchRequest)
        } catch {
            print("Cannot fetch Expenses")
        }
        
        //Map only Query string to Array and return.
        return queries?.map{$0.query ?? ""}
    }
    
    static func removeQueryFromDB(withText text:String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Queries")
        
        //Get particular query string and remove from the DB.
        fetchRequest.predicate = NSPredicate(format: "query == %@", text)
        do {
            let objects = try context.fetch(fetchRequest)
            if let allObjects = objects as? [NSManagedObject]{
                for obj in allObjects {
                    context.delete(obj)
                }
            }
        } catch {
            
        }
        
        do {
            try context.save()
        } catch {
            print("Failed Deleting")
        }

    }
    
}
