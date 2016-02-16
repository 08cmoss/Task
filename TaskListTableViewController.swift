//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Cameron Moss on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TaskController.sharedInstance.tasksArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listTaskCell", forIndexPath: indexPath) as! ButtonTableViewCell

        let task = TaskController.sharedInstance.tasksArray[indexPath.row]
//        cell.textLabel?.text = task.name
//        cell.detailTextLabel?.text = task.notes
        cell.updateWith(task)
        cell.delegate = self

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let task = TaskController.sharedInstance.tasksArray[indexPath.row]
            TaskController.sharedInstance.removeTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            TaskController.sharedInstance.saveToPersistentStorage()
        }     
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toViewSegue" {
            let destinationViewController = segue.destinationViewController as? TaskDetailTableViewController
            if let taskDetailTableViewController = destinationViewController {
                _ = taskDetailTableViewController.view
                
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    taskDetailTableViewController.updateWith(TaskController.sharedInstance.tasksArray[selectedRow])
                }
            }
        }
    }
    

}

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        
        let indexPath = tableView.indexPathForCell(sender)!
        
        let task = TaskController.sharedInstance.tasksArray[indexPath.row]
        task.isComplete = !task.isComplete!.boolValue
        TaskController.sharedInstance.saveToPersistentStorage()
        
        tableView.reloadData()
    }
}
