//
//  SearchViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/19/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource,  UIPickerViewDelegate, APIControllerProtocol {
    var jsonResult : NSDictionary?
    var searchTypes : [String] = ["Isoform", "Pathway"]
    var searchTypeString : String = ""
    lazy var api : APIController = APIController(delegate: self)
    
    @IBOutlet weak var searchTerm: UITextField!
    @IBOutlet weak var searchType: UIPickerView!
    
    @IBAction func searchButton(sender: AnyObject) {
        self.jsonResult = nil
        api.searchIsoform(searchTerm.text);
        //self.performSegueWithIdentifier("SearchResultsSegue", sender: sender)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return searchTypes.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return searchTypes[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        self.searchTypeString = self.searchTypes[row]
    }
    
    // The APIControllerProtocol method
    func didReceiveAPIResults(results: NSDictionary) {
        dispatch_async(dispatch_get_main_queue(), {
            self.jsonResult = results
            
            self.performSegueWithIdentifier("SearchResultsSegue", sender: nil)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
        var viewController: AnyObject! = segue.destinationViewController
        
        if (viewController is SearchResultsViewController) {
            var searchResultsViewController: SearchResultsViewController = segue.destinationViewController as SearchResultsViewController
            
            searchResultsViewController.jsonResult = self.jsonResult
        }
    }
}
