//
//  HistoryDetailViewController.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 8/30/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HistoryDetailViewController: UIViewController {
    var mainOrigin: CGFloat = 0
    var imei: IMEI? {
        willSet {
            self.imeiLabel.text = newValue?.imei
            self.noteTextView.text = newValue?.note
        }
    }
    
    private lazy var btnCopy: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ico_copy")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.appBase
        btn.addTarget(self, action: #selector(copyAction(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var btnClose: UIView = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ico_close")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(closeAction(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var imeiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private lazy var mainBoundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background
        view.shadowAndRadius(cornerRadius: 15, shadowRadius: 0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var maskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupEvents()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mainOrigin = self.mainBoundView.frame.origin.y
    }
    
    private func setupView() {
        self.view.addSubview(self.maskView)
        self.view.addSubview(self.mainBoundView)
        
        self.mainBoundView.addSubview(self.btnCopy)
        self.mainBoundView.addSubview(self.btnClose)
        self.mainBoundView.addSubview(self.imeiLabel)
        self.mainBoundView.addSubview(self.noteTextView)
        
        self.maskView.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalToSuperview()
            maker.bottom.equalTo(self.mainBoundView.snp.top).offset(20)
        }
        
        self.mainBoundView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        self.btnClose.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.width.height.equalTo(30)
        }
        
        self.btnCopy.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-20)
            maker.width.height.equalTo(30)
        }
        
        self.imeiLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
            maker.top.equalTo(self.btnClose.snp.bottom).offset(10)
        }
        
        self.noteTextView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.imeiLabel.snp.bottom).offset(20)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(-20)
            maker.height.equalTo(300)
        }
    }
    
    private func setupEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWasShown(_ notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrameValue =
            info["UIKeyboardBoundsUserInfoKey"] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height
        
        UIView.animate(withDuration: 0.5) {
            self.mainBoundView.frame.origin.y = self.mainOrigin - keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let frameHeight = self.mainBoundView.frame.height
        UIView.animate(withDuration: 0.5) {
            self.mainBoundView.frame.origin.y = self.view.frame.height - frameHeight
        }
    }
    
    private func close() {
        self.noteTextView.endEditing(true)
        self.imei?.note = self.noteTextView.text
        
        UIView.animate(withDuration: 0.3, animations: {
            self.maskView.backgroundColor = UIColor.clear
        }) { (finish) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func dismissAction(_ sender: UITapGestureRecognizer) {
        self.close()
    }
    
    @objc private func closeAction(_ sender: UIButton) {
        self.close()
    }
    
    @objc private func copyAction(_ sender: UIButton) {
        self.noteTextView.endEditing(true)
        UIPasteboard.general.string = self.imei?.toString()
        AppNotify.copySuccessful(from: self)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        self.noteTextView.endEditing(true)
    }
    
    func config(for imei: IMEI) {
        self.imei = imei
    }
}
