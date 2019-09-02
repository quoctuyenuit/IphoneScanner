//
//  ViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import SnapKit
import Vision
import Anchors
import AVFoundation

class IMEIScannerViewController: UIViewController, IMEIScannerViewProtocol {
    var presenter: IMEIScannerPresenterProtocol?
    var boxService: BoxServiceProtocol?
    var blocks: [UIImage] = []
    
    private lazy var pickedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_image")
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    private lazy var contentBoundView: UIView = {
        let subView = UIView()
        subView.layer.borderColor = UIColor.background.cgColor
        subView.layer.borderWidth = 1
        subView.backgroundColor = UIColor.background
        subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTappedAction(_:))))
        return subView
    }()

    private lazy var editBoundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var rotateLeft: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        btn.setImage(UIImage(named: "rotate_left")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.appBase
        btn.addTarget(self, action: #selector(self.rotateLeftAction(_:)), for: UIControl.Event.touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var rotateRight: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "rotate_right")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.appBase
        btn.addTarget(self, action: #selector(self.rotateRightAction(_:)), for: UIControl.Event.touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var btnScanIMEI: UIButton = {
        let btn = UIButton()
        btn.shadowAndRadius(cornerRadius: 5, shadowRadius: 3)
        btn.setTitle(LocalizationHelper.shared.localized(.BUTTON_CHECK_IMEI), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.whiteTwo, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(scanIMEIAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    struct Constants {
        static var BUTTON_HEIGHT = UIScreen.main.scale == 3 ? 55 : 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.boxService?.delegate = self
        self.navigationItem.title = LocalizationHelper.shared.localized(Localizations.TITLE_MANUALLY_SCAN)
    }

    private func setupView() {
        self.view.backgroundColor = UIColor.background
        
        self.view.addSubview(self.contentBoundView)
        self.view.addSubview(self.editBoundView)
        self.view.addSubview(self.btnScanIMEI)
        
        self.contentBoundView.addSubview(self.pickedImage)
        self.editBoundView.addSubview(self.rotateLeft)
        self.editBoundView.addSubview(self.rotateRight)
        
        
        self.pickedImage.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        self.rotateLeft.snp.makeConstraints { (maker) in
            maker.leading.top.bottom.equalToSuperview()
            maker.width.equalTo(Constants.BUTTON_HEIGHT)
            maker.trailing.equalTo(self.rotateRight.snp.leading).offset(-5)
        }
        
        self.rotateRight.snp.makeConstraints { (maker) in
            maker.trailing.top.bottom.equalToSuperview()
            maker.width.equalTo(Constants.BUTTON_HEIGHT)
        }
        
        self.contentBoundView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalTo(self.editBoundView.snp.top).offset(-10)
        }
        
        self.editBoundView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constants.BUTTON_HEIGHT)
            maker.width.greaterThanOrEqualTo(0)
            maker.centerX.equalToSuperview()
        }
        
        self.btnScanIMEI.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.top.equalTo(self.editBoundView.snp.bottom).offset(15)
            maker.height.equalTo(Constants.BUTTON_HEIGHT)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
    }
    
    func didDetected(didDetect image: UIImage, results: [VNTextObservation]) {
        self.boxService?.handle(layer: self.pickedImage.layer,
                                image: image,
                                results: results,
                                on: self.contentBoundView)
    }
    
    func didRecognized(listImeis: [String]) {
        if SettingsGlobal.isAutoCopy {
            UIPasteboard.general.strings = listImeis
        }
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

extension IMEIScannerViewController {
    @objc private func rotateLeftAction(_ sender: UIButton) {
        if let image = self.pickedImage.image?.rotate(radians: Float(-Double.pi / 2)) {
            self.pickedImage.image = image
            self.presenter?.detectTextInImage(image: image)
        }
    }
    
    @objc private func rotateRightAction(_ sender: UIButton) {
        if let image = self.pickedImage.image?.rotate(radians: Float(Double.pi / 2)) {
            self.pickedImage.image = image
            self.presenter?.detectTextInImage(image: image)
        }
    }
    
    @objc private func imageTappedAction(_ sender: UITapGestureRecognizer) {
        self.scanIMEIAction(UIButton())
    }
    
    @objc private func scanIMEIAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Chọn nguồn ảnh", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Thư viện ảnh", style: .default) { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Máy ảnh", style: .default) { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        self.present(alertController, animated: true, completion: nil)
    }
}

extension IMEIScannerViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pickedImage.image = selectedImage.rotate(radians: Float(2*Double.pi))
            self.presenter?.detectTextInImage(image: self.pickedImage.image!)
            self.rotateLeft.isEnabled = true
            self.rotateRight.isEnabled = true
            self.presenter?.recognizeText(source: self.pickedImage.image!)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension IMEIScannerViewController: BoxServiceDelegate {
    func boxService(_ service: BoxServiceProtocol, didDetect images: [UIImage]) {
        self.blocks = images
    }
}
