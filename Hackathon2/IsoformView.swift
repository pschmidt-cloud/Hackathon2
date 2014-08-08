//
//  IsoformView.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/5/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//
import UIKit

class IsoformView: UIView {
    var length : Float = 20
    var jsonResult : NSDictionary!
    
    init (coder aDecoder : NSCoder!) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(dirtyRect: CGRect) {
        var ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(ctx, 0, 0, 1, 1)
        
        let isoformTracks : NSArray = jsonResult["isoformTracks"] as NSArray
        let regions : NSDictionary = isoformTracks[0] as NSDictionary
        let regionArray : NSArray = regions["regions"] as NSArray
        
        var xPos : Int = 0
        var count = 1;
        
        for region  in regionArray {
            var startPos : Int = region["startPos"] as Int
            var str : String  = region["type"] as String
            var displayLength : Int = region["displayLength"] as Int
            var length : Int = region["length"] as Int
            
            CGContextFillRect(ctx, CGRectMake(CGFloat(xPos), 0, CGFloat(length), 10));
            xPos = xPos + length + 1
            count++
            if (count == 20) {
                break
            }
        }
        
        //CGContextFillRect(ctx, CGRectMake(0, 0, CGFloat(self.length), 10));
        //CGContextFillRect(ctx, CGRectMake(15, 25, CGFloat(self.length)/2, 10));
        
    }
    
}