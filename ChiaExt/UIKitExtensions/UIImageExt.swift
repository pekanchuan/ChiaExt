//
//  UIImageExt.swift
//  ChiaExtDemo
//
//  Created by Chia on 2021/1/3.
//

import UIKit

// MARK: - Properties

extension UIImage {
    
#if canImport(CoreImage)
    
    /// Average color for the image
    /// - Returns: optional UIColor
    func averageColor() -> UIColor? {
        // https://stackoverflow.com/questions/26330924
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }
        
        //  CIAreaAverage return a single-pixel image that contains the average color for a given region of an image
        let parameters = [kCIInputImageKey: ciImage, kCIInputExtentKey: CIVector(cgRect: ciImage.extent)]
        guard let outputImage = CIFilter(name: "CIAreaAverage", parameters: parameters)?.outputImage else { return nil }
        
        //  After getting the single-pixel image from the filter extract pixel's RGBA8 data
        var bitmap = [UInt8](repeating: 0, count: 4)
        let workingColorSpace: Any = cgImage?.colorSpace ?? NSNull()
        let context = CIContext(options: [.workingColorSpace: workingColorSpace])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        //  Convert pixel data to UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
    
#endif
    
}

extension UIImage {
    
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
    
    
    /// Scale image size
    /// - Parameter newSize: image new size
    /// - Returns: Optional Image
    func scaled(_ newSize: CGSize) -> UIImage? {
        guard size != newSize else {
            return self
        }
        
        let ratio = max(newSize.width / size.width, newSize.height / size.height)
        let width = size.width * ratio
        let height = size.height * ratio
        
        let scaleRect = CGRect(x: (newSize.width - width) / 2.0, y: (newSize.height - height) / 2.0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(scaleRect.size, false, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        draw(in: scaleRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
}


// MARK: - Initializers

extension UIImage {
    
    
    /// Create UIImage from color and size.
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
    
    /// Create a new image from a base 64 string
    ///  - Parameters:
    ///     - base64String: a base-64 `String`, representing the image
    ///     - scale: The scale factor to assume when interpreting the image data created from the base-64 string. Applying a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a different scale factor changes the size of the image as reported by the `size` property
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }
}
