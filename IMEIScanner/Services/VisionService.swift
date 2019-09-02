//
//  VisionService.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/5/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import Vision
import UIKit


final class VisionService: VisionServiceProtocol {
    weak var delegate: VisionServiceDelegate?
    
    private func inferOrientation(image: UIImage) -> CGImagePropertyOrientation {
        switch image.imageOrientation {
        case .up:
            return CGImagePropertyOrientation.up
        case .upMirrored:
            return CGImagePropertyOrientation.upMirrored
        case .down:
            return CGImagePropertyOrientation.down
        case .downMirrored:
            return CGImagePropertyOrientation.downMirrored
        case .left:
            return CGImagePropertyOrientation.left
        case .leftMirrored:
            return CGImagePropertyOrientation.leftMirrored
        case .right:
            return CGImagePropertyOrientation.right
        case .rightMirrored:
            return CGImagePropertyOrientation.rightMirrored
        @unknown default:
            return CGImagePropertyOrientation.up
        }
    }
    
    func makeRequestRectangle(image: UIImage) {
        guard let cgImage = image.cgImage else {
            assertionFailure()
            return
        }
        
        let handler = VNImageRequestHandler(
            cgImage: cgImage,
            orientation: inferOrientation(image: image),
            options: [VNImageOption: Any]()
        )
        
        let request = VNDetectTextRectanglesRequest(completionHandler: { [weak self] request, error in
            DispatchQueue.main.async {
                self?.handle(image: image, request: request, error: error)
            }
        })
        
        request.reportCharacterBoxes = true
        
        do {
            try handler.perform([request])
        } catch {
            print(error as Any)
        }
    }
    
    private func handle(image: UIImage, request: VNRequest, error: Error?) {
        guard
            let results = request.results as? [VNTextObservation]
            else {
                return
        }
        
        delegate?.visionService(self, didDetect: image, results: results)
    }
    
}
