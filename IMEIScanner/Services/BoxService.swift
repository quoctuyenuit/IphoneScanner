//
//  BoxService.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/5/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Vision
import AVFoundation

final class BoxService: BoxServiceProtocol {
    private var layers: [CALayer] = []
    
    weak var delegate: BoxServiceDelegate?
    
    func handle(layer: CALayer, image: UIImage, results: [VNTextObservation], on view: UIView) {
        
        layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        
        var images: [UIImage] = []
        let results = results.filter {
            $0.confidence > 0.5 && $0.boundingBox.size.width > 5*$0.boundingBox.size.height
        }
        
        results.forEach { (result) in
            do {
                var transform = CGAffineTransform.identity
                transform = transform.scaledBy(x: image.size.width, y: -image.size.height)
                transform = transform.translatedBy(x: 0, y: -1)
                let rect = result.boundingBox.applying(transform)
                
                let biggerRect = rect.scaleUp(scaleUp: 0.2)
                
                if let croppedImage = crop(image: image, rect: biggerRect) {
                    images.append(croppedImage)
                }
            }
            
            do {
                let normalisedRect = normalise(box: result)
                self.drawBox(overlayLayer: layer, normalisedRect: normalisedRect)
            }
        }
        
        delegate?.boxService(self, didDetect: images)
    }
    
    private func crop(image: UIImage, rect: CGRect) -> UIImage? {
        guard let cropped = image.cgImage?.cropping(to: rect) else {
            return nil
        }
        
        return UIImage(cgImage: cropped, scale: image.scale, orientation: image.imageOrientation)
    }
    
    private func drawBox(overlayLayer: CALayer, normalisedRect: CGRect) {
        let x = normalisedRect.origin.x * overlayLayer.frame.size.width
        let y = normalisedRect.origin.y * overlayLayer.frame.size.height
        let width = normalisedRect.width * overlayLayer.frame.size.width
        let height = normalisedRect.height * overlayLayer.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: x, y: y, width: width, height: height).scaleUp(scaleUp: 0.2)
        outline.borderWidth = 1.0
        outline.borderColor = UIColor.green.cgColor
        
        overlayLayer.addSublayer(outline)
    }
    
    private func normalise(box: VNTextObservation) -> CGRect {
        return CGRect(
            x: box.boundingBox.origin.x,
            y: (1 - box.boundingBox.origin.y - box.boundingBox.height),
            width: box.boundingBox.size.width,
            height: box.boundingBox.size.height
        )
    }
    
    private func reset() {
        layers.forEach {
            $0.removeFromSuperlayer()
        }
        
        layers.removeAll()
    }
}

extension CGRect {
    func scaleUp(scaleUp: CGFloat) -> CGRect {
        let biggerRect = self.insetBy(
            dx: -self.size.width * scaleUp,
            dy: -self.size.height * scaleUp
        )
        
        return biggerRect
    }
}
