//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableview: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        cell.update(withTask: task)
        
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        TaskController.shared.fetchedResultsController.sectionIndexTitles[section] == "0" ? "Incomplete" : "Complete"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: taskToDelete)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailTableViewController else { return }
            let taskToSend = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destination.task = taskToSend
        }
    }
}
extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.taskIsComplete(for: task)
        sender.update(withTask: task)
    }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.beginUpdates()
       }
       
       func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.endUpdates()
       }
}

