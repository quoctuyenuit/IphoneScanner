//
//  ShowResultsViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class ShowResultsViewController: UIViewController, ShowResultsViewProtocol {
    var presenter: ShowResultsPresenterProtocol?
    private var imeisList: [String] = []
    
    private var copyAllBtn: UIButton = {
        let btn = UIButton()
        btn.shadowAndRadius()
        btn.setTitle(LocalizationHelper.shared.localized(.BUTTON_COPY_ALL), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(copyAllAction(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private var checkImeiBtn: UIButton = {
        let btn = UIButton()
        btn.shadowAndRadius()
        btn.setTitle(LocalizationHelper.shared.localized(.BUTTON_CHECK_IMEI), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(checkImeiAction(_:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var contentBoundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.shadowAndRadius(cornerRadius: 15, shadowRadius: 0.5)
        return view
    }()
    
    private lazy var mask: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.maskTappedAction(_:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    convenience init(imeisList: [String]) {
        self.init(nibName: nil, bundle: nil)
        self.imeisList = imeisList
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
    }
    
    private func setupView() {
        self.view.addSubview(self.mask)
        self.view.addSubview(self.contentBoundView)
        
        let mainView = UIView()
        var topConstraint = mainView.snp.top
        
        self.imeisList.forEach { (imei) in
            let card = IMEIResultCard(imei: imei)
            let separateLine = UIView()
            separateLine.backgroundColor = UIColor.lightGray
            card.delegate = self
            
            mainView.addSubview(card)
            mainView.addSubview(separateLine)

            card.snp.makeConstraints { (maker) in
                maker.top.equalTo(topConstraint).offset(10)
                maker.leading.trailing.equalToSuperview()
                maker.height.greaterThanOrEqualTo(50)
            }
            
            separateLine.snp.makeConstraints({ (maker) in
                maker.top.equalTo(card.snp.bottom).offset(10)
                maker.width.equalToSuperview().multipliedBy(0.7)
                maker.height.equalTo(0.5)
                maker.centerX.equalToSuperview()
            })
            
            topConstraint = separateLine.snp.bottom
        }
        
        mainView.addSubview(self.copyAllBtn)
        mainView.addSubview(self.checkImeiBtn)
        self.copyAllBtn.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(40)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(topConstraint).offset(10)
        }
        
        self.checkImeiBtn.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(40)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.copyAllBtn.snp.bottom).offset(10)
            maker.bottom.equalToSuperview()
        }
        
        self.contentBoundView.addSubview(mainView)
        
        self.mask.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.contentBoundView.snp.top).offset(20)
        }
        
        mainView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(10)
            maker.height.greaterThanOrEqualTo(0)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        self.contentBoundView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.greaterThanOrEqualTo(0)
        }
    }
    
    @objc private func maskTappedAction(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.mask.backgroundColor = UIColor.clear
        }) { (finish) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func copyAllAction(_ sender: UIButton) {
        UIPasteboard.general.strings = self.imeisList
        let msg = "IMEIS:\n" + self.imeisList.joined(separator: "\n")
        AppNotify.show(for: msg, from: self)
    }
    
    @objc private func checkImeiAction(_ sender: UIButton) {
        guard let url = URL(string: "https://taoden.vn/product/gsx-lite") else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ShowResultsViewController: IMEIResultCardDelegate {
    func imeiResultCard(_ version: IMEIResultCard, didCopy imei: String) {
        UIPasteboard.general.string = imei
        let msg = "IMEI:\n" + imei
        AppNotify.show(for: msg, from: self)
    }
}
