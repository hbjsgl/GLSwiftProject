//
//  UILabel+GLExtension.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2019/1/18.
//  Copyright © 2019 郭磊. All rights reserved.
//

import UIKit

struct RunTimeLabelKey {
    
    ///是否拥有复制功能
    static let isCopyable = UnsafeRawPointer.init(bitPattern: "isCopyable".hashValue)
}


//MARK: ---- 初始化 -----
extension UILabel {
    
    /// 自定义初始化方法
    ///
    /// - Parameters:
    ///   - font:字体大小
    ///   - color: 颜色，默认黑色
    ///   - alignment: 位置
    ///   - text: 文字内容
    convenience init(font:CGFloat?,color:UIColor? = UIColor.black,alignment:NSTextAlignment?,text:String) {
        
        self.init()
        self.font = UIFont.systemFont(ofSize: font ?? 16)
        self.textColor = color
        self.text = text
        
        let textAlignment = alignment ?? NSTextAlignment.left
        self.textAlignment = textAlignment
        
    }
    
}


//MARK: ---- 事件扩展 ----
extension UILabel {
    
    var isCopyable: Bool? {
        
        set {
            objc_setAssociatedObject(self, RunTimeLabelKey.isCopyable!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            //添加手势
            self.isUserInteractionEnabled = true
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyEvent))
            self.addGestureRecognizer(longPress)
        }
        
        get {
            return objc_getAssociatedObject(self, RunTimeLabelKey.isCopyable!) as? Bool
        }
    }
    
    @objc func longPressCopyEvent() {
        
        //成功响应者
        becomeFirstResponder()
        
        //拿出菜单控制器单例
        let menu = UIMenuController.shared
        //创建复制的item
        let copyItem = UIMenuItem(title: "复制", action: #selector(copyText))
        //将复制的item给控制器
        menu.menuItems = [copyItem]
        //菜单控制器的点击区域为这个控制器的bounds
        menu.setTargetRect(bounds, in: self)
        //菜单o控制器默认不可见
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func copyText(){
        
        //UIPasteboard的string只接受 NSString，防止是attributedText
        if (self.text != nil) {
            UIPasteboard.general.string = self.text
        }else {
            UIPasteboard.general.string = self.attributedText?.string
        }
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (action == #selector(copyText)) {
            
            return true
        }else {
            return false
        }
    }
    
    ///
    override open var canBecomeFirstResponder: Bool {
        return true
    }
}

