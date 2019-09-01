//
//  IMEIScannerProtocols.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import Vision
import AVFoundation

//======================================================================
//View
//======================================================================
protocol IMEIScannerViewProtocol {
    var presenter: IMEIScannerPresenterProtocol? { get set }
    var boxService: BoxServiceProtocol? { get set }
    func didDetected(didDetect image: UIImage, results: [VNTextObservation])
    func didRecognized(listImeis: [String])
}

//======================================================================
//Presenter
//======================================================================
protocol IMEIScannerPresenterProtocol {
    var view: IMEIScannerViewProtocol? { get set }
    var interactor: IMEIScannerInteractorProtocol? { get set }
    var router: IMEIScannerRouterProtocol? { get set }
    
    func detectTextInImage(image: UIImage)
    func returnTextDetection(didDetect image: UIImage, results: [VNTextObservation])
    func recognizeText(source image: UIImage)
    func didRecognizedText(text: String)
}

//======================================================================
//Interactor
//======================================================================
protocol IMEIScannerInteractorProtocol {
    var presenter: IMEIScannerPresenterProtocol? { get set }
    var visionService: VisionServiceProtocol? { get set }
    
    func detectText(image: UIImage)
    func recognizeText(source image: UIImage)
}

//======================================================================
//Router
//======================================================================
protocol IMEIScannerRouterProtocol {
    static func createIMEIScannerView() -> UIViewController
    static func createIMEIScannerVideo() -> UIViewController
}

//======================================================================
//Vision Service
//======================================================================
protocol VisionServiceProtocol {
    var delegate: VisionServiceDelegate? { get set }
    func makeRequestRectangle(image: UIImage)
    
}

//======================================================================
//Vision Service Delegate
//======================================================================
protocol VisionServiceDelegate: class {
    func visionService(_ version: VisionServiceProtocol, didDetect image: UIImage, results: [VNTextObservation])
}

//======================================================================
//Box Service Delegate
//======================================================================
protocol BoxServiceProtocol {
    var delegate: BoxServiceDelegate? { get set }
    func handle(layer: CALayer, image: UIImage, results: [VNTextObservation], on view: UIView)
}

//======================================================================
//Box Service Delegate
//======================================================================
protocol BoxServiceDelegate: class {
    func boxService(_ service: BoxServiceProtocol, didDetect images: [UIImage])
}
