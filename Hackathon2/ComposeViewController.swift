//
//  ComposeViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/6/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var composeText: UITextView!
    @IBOutlet weak var charactersLabel: UILabel!
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeText.layer.borderColor = UIColor.blackColor().CGColor
        composeText.layer.borderWidth = 0.5
        composeText.layer.cornerRadius = 5
        composeText.delegate = self
        
        composeText.becomeFirstResponder()
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        if (!composeText.text.isEmpty) {
            var comment : PFObject = PFObject(className: "Comment")
            comment["comment"] = composeText.text
            comment["user"] = PFUser.currentUser()
        
            comment.saveInBackground()
        }
        
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool {
            
            var newLength : Int = (composeText.text as NSString).length
            charactersLabel.text = "\(newLength)"
            
            return true
    }
}
