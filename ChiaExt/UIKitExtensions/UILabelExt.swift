//
//  UILabelExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2022/1/2.
//

import UIKit

extension UILabel {
    
    convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        self.text = text
    }
    
    var requireHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
