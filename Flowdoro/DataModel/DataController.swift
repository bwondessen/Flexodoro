//
//  DataController.swift
//  Flexodoro
//
//  Created by Bruke on 4/17/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "StatsModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Could not save data")
        }
    }
    
    func addStats(timeStudied: Double, context: NSManagedObjectContext) {
        let stats = Stats(context: context)
        stats.id = UUID()
        stats.date = Date()
        stats.cylces += 1
        stats.timeStudied = timeStudied
        
        save(context: context)
    }
}
