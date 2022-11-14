//
//  QRCodeGenerate.swift
//  OneHome
//
//  Created by Macbook Pro 2017 on 7/21/20.
//  Copyright © 2020 VNPT Technology. All rights reserved.
//

import Foundation
import UIKit
func generateQRCode(from string: String, image: UIImageView) -> UIImage? {
    let data = string.data(using: String.Encoding.utf8)
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }

        filter.setValue(data, forKey: "inputMessage")

        filter.setValue("H", forKey: "inputCorrectionLevel")
        colorFilter.setValue(filter.outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor.clear, forKey: "inputColor1") // Background white
        colorFilter.setValue(CIColor.black, forKey: "inputColor0") // Foreground or the barcode RED
        guard let qrCodeImage = colorFilter.outputImage
            else {
                return nil
        }
        let scaleX = image.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = image.frame.size.height / qrCodeImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)


        if let output = colorFilter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }
    return nil
}
