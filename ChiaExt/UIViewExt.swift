//
//  UIViewExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2021/7/8.
//

import UIKit

extension UIView {
    
    var width: CGFloat {
        get { return self.frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get { return self.frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var size: CGSize  {
        get { return self.frame.size }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var origin: CGPoint {
        get { return self.frame.origin }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var x: CGFloat {
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get { return self.center.x }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
            
        }
    }
    
    var centerY: CGFloat {
        get { return self.center.y }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var top : CGFloat {
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var bottom : CGFloat {
        get { return frame.origin.y + frame.size.height }
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }
    
    var right : CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width
            self.frame = frame
        }
    }
    
    var left : CGFloat {
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.origin.x  = newValue
            self.frame = frame
        }
    }
    
    /// set shadow
    /// - Parameters:
    ///   - shadowOffset: CGSize
    ///   - shadowColor: CGColor
    ///   - shadowOpacity: Float
    ///   - shadowRadius: CGFloat
    ///   - cornerRadius: CGFloat
    func set(shadowOffset: CGSize, shadowColor: CGColor, shadowOpacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    
    /// set corners
    /// - Parameters:
    ///   - corners: CACornerMask
    ///   - radius: CGFloat
    ///   - clipToBounds: Bool
    func setCornerBorders(corners: CACornerMask, radius: CGFloat, clipToBounds: Bool = false) {
        self.clipsToBounds = clipToBounds
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    enum ViewSide {
        case top, left, right, bottom
    }
    
    
    /// Add side border for UIView
    /// - Parameters:
    ///   - side: view's side
    ///   - color: border color
    ///   - thickness: border width
    func addBorder(to side: ViewSide, borderColor color: UIColor, borderThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}
