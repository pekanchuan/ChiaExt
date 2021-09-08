//
//  UIViewExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2021/7/8.
//

import UIKit

// MARK: - enums

extension UIView {
    
    enum ViewSide {
        case top, left, right, bottom
    }
    
}

extension UIView {
    
    
    /// SwifterSwift: Add shadow to view.
    ///
    /// - Note: This method only works with non-clear background color, or if the view has a `shadowPath` set.
    /// See parameter `opacity` for detail.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is black alpha 0.5).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5). It will also be affected by the `alpha` of  `backgroundColor`
    func addShadow(ofColor color: UIColor = UIColor(white: 0, alpha: 0.5),
                   radius: CGFloat = 3,
                   offset: CGSize = .zero,
                   opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    
    /// Set some or all corners radiues of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.layerMinXMinYCorner, .layerMaxXMaxYCorner]).
    ///   - radius: CGFloat
    ///   - clipToBounds: Bool
    func setCornerBorders(corners: CACornerMask, radius: CGFloat, clipToBounds: Bool = false) {
        clipsToBounds = clipToBounds
        layer.cornerRadius = radius
        layer.maskedCorners = corners
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
    
    
    /// Load view from nib.
    /// - Parameters:
    ///   - name: nib name
    ///   - bundleOrNil: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    static func loadFromNib(nibName name: String, bundle bundleOrNil: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundleOrNil).instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    
    /// Load view of a certain type from nib
    /// - Parameters:
    ///   - className: UIView type
    ///   - bundleOrNil: bundle of nib (default if nil)
    /// - Returns: UIView
    static func loadFromNib<T: UIView>(withClass className: T.Type, bundle bundleOrNil: Bundle? = nil) -> T {
        let name = String(describing: className)
        guard let view = UINib(nibName: name, bundle: bundleOrNil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("First element in xib file \(name) is not of type \(name)")
        }
        return view
    }
    
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    
}
