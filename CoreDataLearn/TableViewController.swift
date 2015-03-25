//
//  TableViewController.swift
//  CoreDataLearn
//
//  Created by medicool on 15/3/25.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var dataArr:Array<AnyObject> = []
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        //添加数据
        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context!)
        row.setValue("zk", forKey: "name")
        row.setValue(1, forKey: "age")
        
        context?.save(nil)
        refreshData()
    }
    
    func refreshData(){
    
        //获取(查找)数据
        var f = NSFetchRequest(entityName: "Users")
        dataArr = context.executeFetchRequest(f, error: nil)!
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        var label = cell.viewWithTag(2) as UILabel;
        var name = dataArr[indexPath.row].valueForKey("name") as String
        var sex = dataArr[indexPath.row].valueForKey("age") as Int
        label.text = "name:\(name)--sex:\(sex)"
        return cell
    }
  
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var data = dataArr[indexPath.row] as NSManagedObject;
        
        var vc = storyboard?.instantiateViewControllerWithIdentifier("UpdateVC") as UpdateDataViewController;
        vc.data = data
        presentViewController(vc, animated: true, completion: nil);
        
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
    
            // 删除数据
            context.deleteObject(dataArr[indexPath.row] as NSManagedObject)
            refreshData()
            context.save(nil)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            
        }    
    }
}
