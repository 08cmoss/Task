//
//  TaskController.swift
//  Task
//
//  Created by Cameron Moss on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    private let taskKey = "taskKey"
    
    static var sharedInstance = TaskController()
    
    var tasksArray: [Task] {
        let request = NSFetchRequest(entityName: "Task")
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            return try moc.executeFetchRequest(request) as! [Task]
        } catch {
            return []
        }
    }
    
    var completedTasks: [Task] {
        return tasksArray.filter({$0.isComplete!.boolValue})
    }
    
    var incompleteTasks: [Task] {
        return tasksArray.filter({!$0.isComplete!.boolValue})
    }
    
    func addTask(task: Task) {
        
        self.saveToPersistentStorage()
    }
    
    func removeTask(task: Task) {
        //tasksArray.removeAtIndex(indexPath.row)
        task.managedObjectContext?.deleteObject(task)
    }
    
    
    func saveToPersistentStorage() {
        //NSKeyedArchiver.archiveRootObject(self.tasksArray, toFile: self.filePath(taskKey))
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
           print("Error saving managed object context")
        }
    }
    
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let tasksPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return tasksPath
    }
}
