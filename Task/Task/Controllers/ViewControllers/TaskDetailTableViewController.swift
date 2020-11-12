//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    var dueDateValue: Date?
//    var isComplete: Bool?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = dueDatePicker
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              let dueString = dueTextField.text,
              let due = dateFormatter.date(from: dueString),
              let note = notesTextField.text else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: note, due: due)
        } else {
            TaskController.shared.add(name: name, notes: note, due: due)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueTextField.text = dueDatePicker.date.stringValue()
        dueDateValue = sender.date
    }
    @IBAction func userTappedView(_ sender: Any) {
        nameTextField.resignFirstResponder()
        dueTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    func updateViews() {
        guard let task = task else { return }
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dueTextField.text = task.due?.stringValue()
    }
    
    
    
    
}
