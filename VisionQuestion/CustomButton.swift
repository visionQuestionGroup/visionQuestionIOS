//
//  CustomButton.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/17/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var fillColor: UIColor = UIColor.clearColor()
    @IBInspectable var strokeColor: UIColor = UIColor.blackColor()
    @IBInspectable var strokeWidth: CGFloat = 2
    
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        let insetRect = CGRectInset(rect, strokeWidth/2, strokeWidth/2)
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        
        fillColor.set()
        
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        
        strokeColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
    }
    
}

@IBDesignable class CustomView: UIImageView {
    
    @IBInspectable var imageViewRadius: CGFloat = 15 {
        
        didSet {
            
            self.layer.cornerRadius = imageViewRadius
            self.layer.masksToBounds = true
            
        }
        
    }
    
}

