//
//  UIButtonExt.swift
//  ChiaExtDemo
//
//  Created by Chia on 2021/1/3.
//

import UIKit

extension UIButton {
    
    /// Horizontal align title text and image.
    /// - Parameters:
    ///   - spacing: spacing between title text and image.
    ///   - imageFirst: set true make image left title text
    func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -edgeOffset, bottom: 0, right: edgeOffset)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: -edgeOffset)
        
        if !imageFirst {
            transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    
    /// Vertical align title text and image.
    /// - Parameters:
    ///   - spacing: spacing between title text and image.
    ///   - imageTop: set true make image  top title text.
    func alignVertical(spacing: CGFloat, imageTop: Bool) {
        guard let imageSize = imageView?.image?.size,
              let text = titleLabel?.text,
              let font = titleLabel?.font
        else { return }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let imageVerticalOffset = (titleSize.height + spacing) / 2
        let titleVerticalOffset = (imageSize.height + spacing) / 2
        let imageHorizontalOffset = (titleSize.width) / 2
        let titleHorizontalOffset = (imageSize.width) / 2
        let sign: CGFloat = imageTop ? 1 : -1
        
        imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign, left: imageHorizontalOffset, bottom: imageVerticalOffset * sign, right: -imageHorizontalOffset)
        titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign, left: -titleHorizontalOffset, bottom: -titleVerticalOffset * sign, right: titleHorizontalOffset)
        
        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing) / 2
        contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
 
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
 
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
 
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
 
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: state)
    }
}
