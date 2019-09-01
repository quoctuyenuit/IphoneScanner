//
//  IMEIScannerInteractor.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Vision
import Firebase

class IMEIScannerInteractor: IMEIScannerInteractorProtocol {
    var visionService: VisionServiceProtocol?
    var presenter: IMEIScannerPresenterProtocol?
    var textRecognizer: VisionTextRecognizer?
    
    init() {
        self.visionService = VisionService()
        self.visionService?.delegate = self
        let vision = Vision.vision()
        self.textRecognizer = vision.onDeviceTextRecognizer()
    }
    func detectText(image: UIImage) {
        self.visionService?.makeRequestRectangle(image: image)
    }
    
    func recognizeText(source image: UIImage){
        let visionImage = VisionImage(image: image)
        self.textRecognizer?.process(visionImage, completion: { (visionText, error) in
            guard error == nil, let visionText = visionText, !visionText.text.isEmpty else {
                self.presenter?.didRecognizedText(text: "")
                return
            }
            self.presenter?.didRecognizedText(text: visionText.text)
        })
    }
}

extension IMEIScannerInteractor: VisionServiceDelegate {
    func visionService(_ version: VisionServiceProtocol, didDetect image: UIImage, results: [VNTextObservation]) {
        self.presenter?.returnTextDetection(didDetect: image, results: results)
    }
}
