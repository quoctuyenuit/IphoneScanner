//
//  QRScannerController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import Foundation
import AVFoundation
import Vision

class IMEIScannerVideoController: UIViewController, IMEIScannerViewProtocol, AVCaptureVideoDataOutputSampleBufferDelegate {
    var boxService: BoxServiceProtocol?
    
    var presenter: IMEIScannerPresenterProtocol?
    //MARK: - Properties config camera
    private lazy var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    //MARK: - Properties Square
    private lazy var focusView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "im_frame")
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private struct Constants {
        static let FOCUS_PADDING: CGFloat = 7
        static let FOCUS_BORDER: CGFloat = 2
        static let TITLE_HEIGHT: CGFloat = 50
    }
    
    private lazy var topView: UIView = {
        return self.createViewElement()
    }()
    private lazy var leftView: UIView = {
        return self.createViewElement()
    }()
    private lazy var rightView: UIView = {
        return self.createViewElement()
    }()
    private lazy var bottomView: UIView = {
        return self.createViewElement()
    }()
    fileprivate lazy var colorDefault: UIColor = {
        return UIColor(white: 0 , alpha: 0.5)
    }()
    
    fileprivate var parentVCL: UIViewController?
    
    fileprivate var focusFrame: CGRect {
        var barHeight: CGFloat = 0
        if let naviBar = self.navigationController?.navigationBar {
            barHeight = naviBar.frame.origin.y + naviBar.frame.height
        }
        
        let screenWidth = self.view.bounds.size.width
        let screenHeight = self.view.bounds.size.height - barHeight
        
        let squareWidth = screenWidth - Constants.FOCUS_PADDING * 2
        let squareHeight = screenHeight - Constants.FOCUS_PADDING * 2 - Constants.TITLE_HEIGHT
        
        let originX: CGFloat = (screenWidth - squareWidth) / 2
        let originY: CGFloat = (screenHeight + Constants.TITLE_HEIGHT - squareHeight) / 2
        return CGRect(x: originX, y: originY, width: squareWidth, height: squareHeight)
    }
    
    //MARK: - Processing Status
    enum ProcessGoType {
        case up
        case down
    }
    fileprivate var timer: Timer?
    
    fileprivate lazy var processingView: UIView = {
        let view = UIView()
        let width = self.focusFrame.width - Constants.FOCUS_BORDER * 2
        view.frame = CGRect(x: self.focusFrame.origin.x + Constants.FOCUS_BORDER , y: self.focusFrame.origin.y, width: width, height: 1)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    //MARK: - SetupView
    private lazy var captureMetadataOutput = AVCaptureMetadataOutput()
    
    private func setupView() {
        self.focusView.frame = self.focusFrame
        self.configBackground()
        
        self.view.layer.addSublayer(self.focusView.layer)
    }
    
    private func configBackground() {
        let frame = self.focusView.frame
        self.topView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: frame.origin.y + Constants.FOCUS_BORDER))
        self.bottomView.frame = CGRect(x: 0, y: frame.origin.y + frame.size.height - Constants.FOCUS_BORDER, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - Constants.FOCUS_BORDER)
        self.leftView.frame = CGRect(x: 0, y: frame.origin.y + Constants.FOCUS_BORDER, width: frame.origin.x + Constants.FOCUS_BORDER, height: frame.size.height - 2 * Constants.FOCUS_BORDER)
        self.rightView.frame = { () -> CGRect in
            var f = self.leftView.frame
            f.origin.x = frame.origin.x + frame.size.width - Constants.FOCUS_BORDER
            f.size.width = UIScreen.main.bounds.width - f.origin.x
            return f
        }()
        
        let textlayer = CATextLayer()
        textlayer.frame = CGRect(x: 0, y: 20, width: self.view.bounds.width, height: Constants.TITLE_HEIGHT)
        textlayer.fontSize = 13
        textlayer.alignmentMode = .center
        textlayer.string = "Chạm để quét IMEI"
        textlayer.isWrapped = true
        textlayer.truncationMode = .end
        textlayer.backgroundColor = UIColor.clear.cgColor
        textlayer.foregroundColor = UIColor.white.cgColor
        
        self.topView.layer.addSublayer(textlayer)
    }
    
    
    fileprivate func createViewElement() -> UIView {
        let nView = UIView()
        nView.isUserInteractionEnabled = false
        nView.backgroundColor = self.colorDefault
        self.view.layer.addSublayer(nView.layer)
        return nView
    }
    
    //MARK: - Config Camera
    private func configCamera() {
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
                return
            }
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            captureSession.addInput(input)
            
            let videoOutput = AVCaptureVideoDataOutput()
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))
            self.captureSession.addOutput(videoOutput)
            
            //Set video orientation of camera
            let connection = videoOutput.connection(with: AVMediaType.video)
            connection?.videoOrientation = .portrait
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.frame
            guard let videoLayer = videoPreviewLayer else {
                return
            }
            view.layer.insertSublayer(videoLayer, at: 0)
        }
    }
    
    func startScanning() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopScanning() {
        if captureSession.isRunning && captureSession.inputs.count > 0 {
            captureSession.stopRunning()
        }
    }
    
    var sample: CMSampleBuffer?
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection) {
        
        self.sample = sampleBuffer
    }
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCamera()
        self.startScanning()
        self.setupView()
        self.startLoadingView()
        self.navigationItem.title = "Quét tự động"
    }
    
    deinit {
        self.clearTimer()
    }
    
    //MARK: - Function
    private func clearTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startLoadingView() {
        self.view.layer.addSublayer(self.processingView.layer)
        clearTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(showProccessingState),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func showProccessingState() {
        let topOrigin = self.focusFrame.origin.y
        let bottomOrigin = self.focusFrame.origin.y + self.focusFrame.height
        let currentY = self.processingView.frame.origin.y
        self.moveProcessStatus = currentY >= bottomOrigin ? .up : (currentY <= topOrigin ? .down : self.moveProcessStatus )
    }
    
    fileprivate let processingDuration: TimeInterval = 0.3
    
    private var moveProcessStatus: ProcessGoType = .down {
        didSet {
            if moveProcessStatus == .down {
                UIView.animate(withDuration: processingDuration) {
                    self.processingView.frame.origin.y += 2
                }
            } else {
                UIView.animate(withDuration: processingDuration) {
                    self.processingView.frame.origin.y -= 2
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let sample = self.sample else { return }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let image = UIImage.convertFromSampleBuffer(from: sample) {
                self.presenter?.recognizeText(source: image)
            }
        }
    }
}

extension IMEIScannerVideoController {
    func didDetected(didDetect image: UIImage, results: [VNTextObservation]) {
        
    }
    
    func didRecognized(listImeis: [String]) {
        if SettingsGlobal.isAutoCopy {
            UIPasteboard.general.strings = listImeis
        }
        DispatchQueue.main.async {
            if listImeis.count == 0 {
                AppNotify.scanFail(from: self)
            } else {
                listImeis.forEach { (imei) in
                    let imei = IMEI(imei: imei)
                    if !SettingsGlobal.results.contains(imei) {
                        SettingsGlobal.results.append(imei)
                    }
                }
                let resultPopupView = ShowResultsRouter.createShowResultViewController(imeisList: listImeis)
                resultPopupView.modalPresentationStyle = .overFullScreen
                self.present(resultPopupView, animated: true, completion: nil)
            }
        }
    }
}
