//
//  CoreDataHelper.swift
//  MapText
//
//  Created by Ronald Chan on 7/24/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
struct CoreDataHelper
{
    static let context: NSManagedObjectContext = {
        guard let appDelegate=UIApplication.shared.delegate as? AppDelegate
            else {fatalError()}
        let persistentContainer=appDelegate.persistentContainer
        let context=persistentContainer.viewContext
        return context
    }()
    
    static func newLocation()->NotificationLocation
    {
        let loc=NSEntityDescription.insertNewObject(forEntityName: "NotificationLocation", into: context) as! NotificationLocation
        return loc
    }
    static func retrieveLocation()->[NotificationLocation]
    {
        do
        {
            let fetchRequest=NSFetchRequest<NotificationLocation>(entityName: "NotificationLocation")
            let results=try context.fetch(fetchRequest)
            return results
        }
        catch let error
        {
            print("Could not fetch \(error.localizedDescription)")
            return []
        }
    }
    static func saveLocation()
    {
        do
        {
            try context.save()
        }
        catch let error
        {
            print("Could not save \(error.localizedDescription)")
        }
    }
    static func delete(loc:NotificationLocation)
    {
        context.delete(loc)
        saveLocation()
    }
    
}
