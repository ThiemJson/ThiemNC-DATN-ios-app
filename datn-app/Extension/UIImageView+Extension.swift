//
//  UIImageView+Extension.swift
//  OneHome
//
//  Created by Atula on 7/15/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    var circleMask: UIImage? {
            let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
            let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
            imageView.contentMode = .scaleAspectFill
            imageView.image = self
            imageView.layer.cornerRadius = square.width/2
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 5
            imageView.layer.masksToBounds = true
            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
            defer { UIGraphicsEndImageContext() }
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            imageView.layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        let cgwidth: CGFloat = CGFloat(width)
        let cgheight: CGFloat = CGFloat(height)
        let rect: CGRect = CGRect(x: 0, y: 0, width: cgwidth, height: cgheight)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        return image
    }

    func fixOrientation() -> UIImage? {

        if (imageOrientation == .up) { return self }

        var transform = CGAffineTransform.identity

        switch imageOrientation {
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0.0)
            transform = transform.rotated(by: .pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0.0, y: size.height)
            transform = transform.rotated(by: -.pi / 2.0)
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        default:
            break
        }

        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        default:
            break
        }

        guard let cgImg = cgImage else { return nil }

        if let context = CGContext(data: nil,
                                   width: Int(size.width), height: Int(size.height),
                                   bitsPerComponent: cgImg.bitsPerComponent,
                                   bytesPerRow: 0, space: cgImg.colorSpace!,
                                   bitmapInfo: cgImg.bitmapInfo.rawValue) {

            context.concatenate(transform)

            if imageOrientation == .left || imageOrientation == .leftMirrored ||
                imageOrientation == .right || imageOrientation == .rightMirrored {
                context.draw(cgImg, in: CGRect(x: 0.0, y: 0.0, width: size.height, height: size.width))
            } else {
                context.draw(cgImg, in: CGRect(x: 0.0 , y: 0.0, width: size.width, height: size.height))
            }

            if let contextImage = context.makeImage() {
                return UIImage(cgImage: contextImage)
            }

        }

        return nil
    }

}
