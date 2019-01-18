//
//  UIImage+GLExtenston.swift
//  GLSwiftProject
//
//  Created by 郭磊 on 2019/1/18.
//  Copyright © 2019 郭磊. All rights reserved.
//

import UIKit

extension UIImage {
    
    public class func scaleTo(image:UIImage,width:CGFloat,height:CGFloat) -> UIImage {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    ///返回一个调整了宽度的图片，可能是一个低质量的
    public func resizeWithWidth(_ width:CGFloat) -> UIImage {
        
        let aspectSize = CGSize(width: width, height: aspectHeightForWidth(width))
        UIGraphicsBeginImageContext(aspectSize)
        draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    ///返回一个调整了宽度的图片，可能是一个低质量的
    public func resizeWithHeight(_ height:CGFloat) -> UIImage {
        
        let aspectSize = CGSize(width: aspectWidthForHeight(height), height: height)
        UIGraphicsBeginImageContext(aspectSize)
        draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    public func aspectHeightForWidth(_ width:CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    public func aspectWidthForHeight(_ height:CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
    ///返回一个裁剪后的图片
    public func croppedImage(_ bound:CGRect) -> UIImage? {
        guard self.size.width > bound.origin.x else {
            
            print("裁剪的x坐标大于图片宽度")
            return nil
        }
        guard self.size.height > bound.origin.y else {
            print("裁剪的Y坐标大于图片高度")
            return nil
        }
        
        let scaledBounds : CGRect = CGRect(x: bound.origin.x * self.scale, y: bound.origin.y * self.scale, width: bound.width * self.scale, height: bound.height * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage:UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImage.Orientation.up)
        return croppedImage
    }
    
    ///
    public func withColor(_ tintColor:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        return newImage
    }
}
