//
//  CommentViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/7/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import Foundation
import UIKit

class CommentViewController: UITableViewController {
    var commentData : NSMutableArray = NSMutableArray()
    var jsonResult : NSDictionary?
    var dateFormatter : NSDateFormatter!
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()
    }
    
    @IBAction func reloadButtonPressed(sender: AnyObject) {
        loadData()
    }
    
    func loadData() {
        self.commentData.removeAllObjects()
        
        var commentQuery : PFQuery = PFQuery(className: "Comment")
        
        commentQuery.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if (!error) {
                for object in objects {
                    self.commentData.addObject(object)
                }
                
                let reverseArray:NSArray = self.commentData.reverseObjectEnumerator().allObjects
                self.commentData = reverseArray as NSMutableArray
                
                self.tableView!.reloadData()
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    // The protocol methods for UITableViewDataSource and UITableViewDelegate
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell : CommentTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CommentTableViewCell
        
        let comment : PFObject = self.commentData.objectAtIndex(indexPath!.row) as PFObject
        cell.commentText.text = comment.objectForKey("comment") as String
        cell.commentText.alpha = 0
        
        var findUser : PFQuery = PFUser.query()
        
        // TODO: cache objectIds and lookup user from Parse only if not found
        findUser.whereKey("objectId", equalTo: comment.objectForKey("user").objectId)
        
        findUser.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!) -> Void in
            if (!error) {
                let user:PFUser = (objects as NSArray).lastObject as PFUser
                cell.usernameLabel.text = user.username
                
                UIView.animateWithDuration(0.5, animations: {
                    cell.commentText.alpha = 1
                    })
            }
            
        }
        cell.timelineLabel.text = self.dateFormatter.stringFromDate(comment.createdAt)
        
        return cell
    }



}
