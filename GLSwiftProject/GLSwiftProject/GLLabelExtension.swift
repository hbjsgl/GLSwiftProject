//
//  GLLabelExtension.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2018/11/27.
//  Copyright © 2018 郭磊. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init(font:UIFont,color:UIColor,alignment:NSTextAlignment,text:String) {
        
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.text = text
    }
    
    public convenience init(font:UIFont,color:UIColor,alignment:NSTextAlignment) {
        self.init(font: font, color: color, alignment: alignment, text: "")
    }
}
