//
//  IMEIScannerPresenter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Vision

class IMEIScannerPresenter: IMEIScannerPresenterProtocol {
    var view: IMEIScannerViewProtocol?
    
    var interactor: IMEIScannerInteractorProtocol?
    
    var router: IMEIScannerRouterProtocol?
    
    func detectTextInImage(image: UIImage) {
        self.interactor?.detectText(image: image)
    }
    
    func returnTextDetection(didDetect image: UIImage, results: [VNTextObservation]) {
        self.view?.didDetected(didDetect: image, results: results)
    }
    
    func recognizeText(source image: UIImage) {
        self.interactor?.recognizeText(source: image)
    }
    
    func didRecognizedText(text: String) {
        //Filter string here
        let filterdText = text
            .replaceMatches(pattern: "[!@#$%^&*(),.?\":{}|<>\n]", with: ".")
            .replaceMatches(pattern: "[ ]", with: "")
        
        let imeis = filterdText.matches(for: "(^|\\.)(\\d{15})($|\\.)").map {
            $0.replaceMatches(pattern: "\\.", with: "")
        }
        
        let serilist = filterdText.matches(for: "(^|\\.)[eA-Z0-9]{12}($|\\.)").map {
            $0.replaceMatches(pattern: "e", with: "0").replaceMatches(pattern: "\\.", with: "")
        }
        
        self.view?.didRecognized(listImeis: imeis + serilist)
    }
    
}
