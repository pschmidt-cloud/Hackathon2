//
//  APIController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/5/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController {
    
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    func searchIsoform(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let searchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        let escapedSearchTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let urlPath = "https://reports.ingenuity.com/rs/data/isoform/viewer/transcript/\(searchTerm)"
        let url: NSURL = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err?) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            let genomicTrack : NSDictionary = jsonResult["genomicTrack"] as NSDictionary
            let isoformTracks : NSArray = jsonResult["isoformTracks"] as NSArray
            let regions : NSDictionary = isoformTracks[0] as NSDictionary
            let regionArray : NSArray = regions["regions"] as NSArray
            let chromosome : NSString = genomicTrack["chromosome"] as NSString
            
            for region  in regionArray {
                var startPos : Int = region["startPos"] as Int
                var str : String  = region["type"] as String
                var displayLength : Int = region["displayLength"] as Int
                var length : Int = region["length"] as Int
            }
            
            self.delegate.didReceiveAPIResults(jsonResult)
            })
        task.resume()
    }
    
}