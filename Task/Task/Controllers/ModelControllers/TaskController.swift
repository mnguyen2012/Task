//
//  TaskController.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error fetching the objects \(error.localizedDescription)")
        }
    }

    var fetchedResultsController: NSFetchedResultsController<Task>

    func add(name: String, notes: String?, due: Date?) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    func taskIsComplete(for task: Task) {
        task.isComplete.toggle()
    }
    func remove(task:Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func fetchTasks() -> [Task]{
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}//End of class
