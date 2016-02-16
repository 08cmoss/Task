//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Cameron Moss on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task?
    var dueDateValue: NSDate?
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        dueTextField.inputView = datePicker

    }


    // MARK: - Table view data source

    
    func updateWith(task: Task) {
        self.task = task
        title = task.name
        nameTextField.text = task.name
        if let due = task.due {
        dueTextField.text = due.stringValue()
        }
        if let notes = task.notes {
        notesTextView.text = notes
        }
    }
    
    func updateTask() {
        
        let name = nameTextField.text!
        let due = dueDateValue
        let notes = notesTextView.text
        
        if let task = self.task {
            task.name = name
            task.due = due
            task.notes = notes
        } else {
            
            let newTask = Task(name: name, notes: notes, due: due)
            TaskController.sharedInstance.addTask(newTask)
        }
    }

    @IBAction func datePickerTapped(sender: UIDatePicker) {
        
        self.dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
        
    }
    @IBAction func userTappedView(sender: UITapGestureRecognizer) {
        self.nameTextField.resignFirstResponder()
        self.dueTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        updateTask()
        TaskController.sharedInstance.saveToPersistentStorage()
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
}

extension NSDate {
    func stringValue() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        
        return formatter.stringFromDate(self)
    }
}
