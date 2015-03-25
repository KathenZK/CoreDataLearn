//
//  UpdateDataViewController.swift
//  CoreDataLearn
//
//  Created by medicool on 15/3/25.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

import UIKit
import CoreData

class UpdateDataViewController: UIViewController {

    var data:NSManagedObject!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfName.text = data.valueForKey("name") as String
        var age:AnyObject! = data.valueForKey("age")
        tfAge.text = "\(age)"
    }
    
    @IBAction func submite(sender: AnyObject) {
        
        //修改数据
        data.setValue(tfName.text, forKey: "name")
        data.setValue(tfAge.text.toInt(), forKey: "age")
        data.managedObjectContext?.save(nil)
        cancel(sender);
    }

    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
