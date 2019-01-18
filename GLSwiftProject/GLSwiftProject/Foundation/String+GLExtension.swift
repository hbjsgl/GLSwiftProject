//
//  String+GLExtension.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2019/1/18.
//  Copyright © 2019 郭磊. All rights reserved.
//

import UIKit

extension String {
    
    func getTextWidth(font:UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return rect.size.width
    }
}
