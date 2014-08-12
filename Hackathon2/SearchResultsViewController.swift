//
//  SearchResultsViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/5/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, APIControllerProtocol  {
    
    @IBOutlet var appsTableView : UITableView?
    let kCellIdentifier: String = "SearchResultCell"
    var commentData : NSMutableArray = NSMutableArray()
    var searchResults : [String] = ["result1", "result2"]
 
    var jsonResult : NSDictionary?
    
    lazy var api : APIController = APIController(delegate: self)
    
    var imageCache = [String : UIImage]()
    
    @IBAction func logoutUser(sender: AnyObject) {
        PFUser.logOut()
        self.appsTableView!.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO self.loadData()
        
        if (!PFUser.currentUser()) {
            var loginAlert : UIAlertController = UIAlertController(title: "Login", message: "Please login", preferredStyle:UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Username"
                })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Password"
                textfield.secureTextEntry = true
                })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertaction in
                let textFields: NSArray = loginAlert.textFields as NSArray
                let usernameTextField : UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField : UITextField = textFields.objectAtIndex(1) as UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text) {
                    (user:PFUser!, error:NSError!) -> Void in
                    
                    if (user) {
                        println("login succeeded")
                    }
                }
                }))
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertaction in
                let textFields: NSArray = loginAlert.textFields as NSArray
                let usernameTextField : UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField : UITextField = textFields.objectAtIndex(1) as UITextField
                
                var user: PFUser = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackgroundWithBlock{
                    (success: Bool!, error:NSError!) -> Void in
                    if (error) {
                        //let errorString = error.userInfo["error"] as String
                    }
                }
                }))

            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
    
    func loadData() {
        // TODO: Reload search? or possibly load saved results from Parse backend?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.searchIsoform("NM_030649.2");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The APIControllerProtocol method
    func didReceiveAPIResults(results: NSDictionary) {
        dispatch_async(dispatch_get_main_queue(), {
            self.jsonResult = results
            self.appsTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
    }
    
    // The protocol methods for UISearchDisplayDelegate
    func filterContentForSearchText(searchText : String) {
        // TODO
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        
        return true
    }
    
    // The protocol methods for UITableViewDataSource and UITableViewDelegate
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            count =  searchResults.count
        }
        
        return count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        var cell : UITableViewCell!
        
        if (tableView != nil) {
            cell  = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell!
        }
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier)
        }
        
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            var result : String = searchResults[indexPath.row]
           
            cell.textLabel.text = result
            //cell.detailTextLabel.text = "todo"
        } else {
        
            if (jsonResult) {
                let genomicTrack : NSDictionary = jsonResult!["genomicTrack"] as NSDictionary
                let isoformTracks : NSArray = jsonResult!["isoformTracks"] as NSArray
                let name : NSString = genomicTrack["name"] as NSString
                let chromosome: NSString = genomicTrack["chromosome"] as NSString
                let length: Int = genomicTrack["length"] as Int
                
                cell.textLabel.text = name
                cell.detailTextLabel.text = "chromosome: \(chromosome) length: \(length)"
            }
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
        var viewController: AnyObject! = segue.destinationViewController
        
        // if seque.idenitifer == "xxx") then
        if (viewController is DetailsViewController) {
            var detailsViewController: DetailsViewController = segue.destinationViewController as DetailsViewController
            
            detailsViewController.jsonResult = self.jsonResult
        }
    }
    
}


