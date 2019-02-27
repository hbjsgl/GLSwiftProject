//
//  UIView+GLExtenston.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2019/1/18.
//  Copyright © 2019 郭磊. All rights reserved.
//

import UIKit

extension UIView {
    
    public func gl_addSubViews(_ views:[UIView]) {
        
        views.forEach {
            [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    public var x:CGFloat {
        
        get {
            return self.frame.origin.x
        }
        set {
            self.frame = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    public var y:CGFloat {
        
        get {
            return self.frame.origin.y
        }
        set{
            self.frame = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    public var width:CGFloat {
        
        get {
            return self.frame.size.width
        }
        set{
            self.frame = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    public var height:CGFloat {
        
        get {
            return self.frame.size.height
        }
        set{
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    public var left:CGFloat {
        
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }
    
    public var right:CGFloat {
        get {
            return self.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
    
    public var top:CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.y + self.height
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    public var origin:CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame = CGRect(origin: newValue, size: self.frame.size)
        }
    }
    
    public var size:CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame = CGRect(origin: self.frame.origin, size: newValue)
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    public func leftOffset(_ offset:CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    public func rightOffset(_ offset:CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    public func topOffset(_ offset:CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    public func bottomOffset(_ offset:CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    public func alignRight(_ offset:CGFloat) -> CGFloat {
        return self.width - offset
    }
    
    public func removeSubViews() {
        for subView in subviews {
            
            subView.removeSubViews()
        }
    }
    
    public func centerXInSuperView() {
        
        guard let parentView = superview else {
            assertionFailure("GLSwiftExtensions Error:The view \(self) doesn't hava a superview")
            return
        }
        self.x = parentView.width / 2 - self.width / 2
    }
    
    public func centerYInSuperView() {
        
        guard let parentView = superview else {
            assertionFailure("GLSwiftExtensions Error:The view \(self) doesn't hava a superview")
            return
        }
        self.y = parentView.height / 2 - self.height / 2
    }
    
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}

extension UIView {
    
    public func setScale(x:CGFloat,y:CGFloat) {
        
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
    
    public func setCornerRadius(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func addBorder(width:CGFloat,color:UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    public func setCornerRadiusAndAddBorder(radius:CGFloat,width:CGFloat,color:UIColor){
        self.setCornerRadius(radius: radius)
        self.addBorder(width: width, color: color)
    }
    
    public func addShadow(offset:CGSize,radius:CGFloat,color:UIColor,opacity:Float,cornerRadius:CGFloat?=nil){
        
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    public func drawCircle(fillColor:UIColor,strokeColor:UIColor,strokeWidth:CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        layer.addSublayer(shapeLayer)
    }
    
    public func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
