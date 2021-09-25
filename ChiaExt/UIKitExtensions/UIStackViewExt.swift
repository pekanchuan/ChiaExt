//
//  UIStackViewExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2021/9/25.
//

import UIKit

extension UIStackView {
    
    /// Initialize an UIStackVIew with an array of UIView and common parameters.
    /// - Parameters:
    ///   - arrangedSubviews: The UIViews to add to the stack.
    ///   - asix: The axis along which the arranged views are laid out.
    ///   - spacing: The distance in points between the adjacent edges of the stack view’s arranged views (default: 0.0).
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s axis (default: .fill).
    ///   - distribution: The distribution of the arranged views along the stack view’s axis (default: .fill).
    convenience init(arrangedSubviews: [UIView],
                     asix: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0.0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
