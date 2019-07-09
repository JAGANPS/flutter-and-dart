//
//  HomeController.swift
//  Live Update
//
//  Created by Ronny Kibet on 4/11/15.
//  Copyright (c) 2015 TeamAppCreative. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate  {

    @IBOutlet weak var homeTableView: UITableView!
    
    var mObjects = [AnyObject]()
    var userNames = [String]()
    var userStatuses = [String]()
    
    
    override func viewDidLoad() {
        
        //query all status objects
        var queryStatus = PFQuery(className: "Status")
        queryStatus.orderByDescending("createdAt")
        queryStatus.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                self.mObjects = objects
                //found objects
                println(self.mObjects )
                for object in self.mObjects {
                    self.userNames.append(object["user"] as String)
                    self.userStatuses.append(object["newStatus"] as String)
                    
                    //reload data
                    self.homeTableView.reloadData()
                }
                
            }else {
                //no objects found.
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        //check if user is logged in else, log out user
        var currentUser = PFUser.currentUser()
        if currentUser == nil {
            
            performSegueWithIdentifier("logOut", sender: self)
            
        }
        
    }
    
    
    /**number of rows***/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mObjects.count
    }
    
    /***populate each row***/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        
        let mycell: StatusCell = tableView.dequeueReusableCellWithIdentifier("statusCell") as StatusCell
        
        
        mycell.usernameLabel.text = userNames[indexPath.row]
        mycell.statusLabel.text = userStatuses[indexPath.row]
     
        return mycell
        
        
        
    }
    
    /****** on table item click*****/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //open the storyboard with the id statusDetailViewStory and send it some  data
        let viewConroller: StatusDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("statusDetailViewStory") as StatusDetailViewController
        viewConroller.status = userStatuses[indexPath.row]
        self.presentViewController(viewConroller, animated: true, completion: nil)
       
        
    }
    
  



    
    
}
