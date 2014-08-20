//
//  SearchBookmarkedViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/18/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import UIKit

class SearchBookmarkedViewController: UITableViewController, UISearchDisplayDelegate  {
    // The protocol methods for UISearchDisplayDelegate
    func filterContentForSearchText(searchText : String) {
        // TODO
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        
        return true
    }

}

