//
//  DetailsViewController.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/5/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import Foundation

import UIKit
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isoformView: IsoformView!
    
    var jsonResult : NSDictionary!
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isoformView.jsonResult = jsonResult
        
        //albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://i.imgur.com/kLVE6E9.jpg")))
        //isoformView = (IsoformView(frame:self.view.frame))
        
        /*
        let testLabel = UILabel(frame: CGRectMake(0, 0, 120, 40))
        testLabel.text = "Hello, Swift!"
        testLabel.backgroundColor = UIColor(red: 0.9, green: 0.2, blue: 0.2, alpha: 1.0)
        testLabel.textAlignment = NSTextAlignment.Center
        testLabel.layer.masksToBounds = true
        testLabel.layer.cornerRadius = 10
        
        testLabel
        */
        
        /*
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        */
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
    }
    
}