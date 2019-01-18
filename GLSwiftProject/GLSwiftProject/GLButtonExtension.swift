//
//  GLButtonExtension.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2018/11/27.
//  Copyright © 2018 郭磊. All rights reserved.
//

import UIKit

//extension UIButton {
//    
//    public convenience init(x:CGFloat,y:CGFloat,w:CGFloat,h:CGFloat,target:AnyObject,action:Selector) {
//        
//        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
//        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
//    }
//    
//    public func setBackgroundColor(_ color:UIColor,forState:UIControl.State) {
//        
//        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
//        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
//        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
//        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.setBackgroundImage(colorImage, for: forState)
//    }
//}

class GLButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        //设置图片
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 25)
        titleLabel?.frame = CGRect(x: 0, y: self.frame.height - 25, width: self.frame.width, height: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

class GLZanLeftButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: self.frame.width - 25, y: 5, width: 20 , height:  20)
        // 设置title
        titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.width - 30, height: self.frame.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}
