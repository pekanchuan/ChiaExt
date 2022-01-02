//
//  UIScrollViewExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2022/1/2.
//

import UIKit

extension UIScrollView {
    
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    var visibleRect: CGRect {
        let contentWidth = contentSize.width - contentOffset.x
        let contentHeight = contentSize.height - contentOffset.y
        return CGRect(origin: contentOffset, size: CGSize(width: min(min(bounds.size.width, contentSize.width), contentWidth), height: min(min(bounds.size.height, contentSize.height), contentHeight)))
    }
}


extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }
    
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -contentInset.left, y: contentOffset.y), animated: animated)
    }
    
    func scrollToBottom(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: max(0, contentSize.height - bounds.height) + contentInset.bottom), animated: animated)
    }
    
    func scrollToRight(animated: Bool = true) {
        setContentOffset(CGPoint(x: max(0, contentSize.width - bounds.width) + contentInset.right, y: contentOffset.y), animated: animated)
    }
    
    func scrollUp(animated: Bool = true) {
        let minY = -contentInset.top
        let y = max(minY, contentOffset.y - bounds.height)
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }
    
    func scrollLeft(animated: Bool = true) {
        let minX = -contentInset.left
        let x = max(minX, contentOffset.x - bounds.width)
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
    
    func scrollDown(animated: Bool = true) {
        let maxY = max(0, contentSize.height - bounds.height) + contentInset.bottom
        let y = min(maxY, contentOffset.y + bounds.height)
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }
    
    func scrollRight(animated: Bool = true) {
        let maxX = max(0, contentSize.width - bounds.width) + contentInset.right
        let x = min(maxX, contentOffset.x + bounds.width)
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
}
