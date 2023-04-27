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
    
    @Published var savedEntities: [Stats] = []
    
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
    
    func addStats(timeStudied: Double, totalTimeStudied: Double, breakTime: Double, totalBreakTime: Double, context: NSManagedObjectContext) {
        let stats = Stats(context: context)
        stats.id = UUID()
        stats.date = Date()
        stats.cycles += 1
        stats.timeStudied = timeStudied
        stats.totalTimeStudied = totalTimeStudied
        stats.breakTime = breakTime
        stats.totalBreakTime = totalBreakTime
        
        save(context: context)
    }
    
    func addTasks(taskName: String, taskColor: String? = nil, timeStudied: Double, totalTimeStudied: Double, context: NSManagedObjectContext) {
        let tasks = Tasks(context: context)
        tasks.id = UUID()
        tasks.date = Date()
        tasks.taskName = taskName
        tasks.taskColor = taskColor
        tasks.timeStudied = timeStudied
        tasks.totalTimeStudied = totalTimeStudied
        
        save(context: context)
    }
    
    func updateTimeStudiedForTask(task: Stats, taskName: String, timeStudied: Double) {
    }
}
