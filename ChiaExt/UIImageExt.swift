//
//  UIImageExt.swift
//  ChiaExtDemo
//
//  Created by Chia on 2021/1/3.
//

import UIKit

extension UIImage {
    //  MARK:   根据颜色生成图片
    static func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //  MARK:   渐变色图片
    static func gradientImage(bounds: CGRect, colors: [CGColor], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 0, y: 1)) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
