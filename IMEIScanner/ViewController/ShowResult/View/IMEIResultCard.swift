//
//  IMEIResultCard.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import SnapKit

protocol IMEIResultCardDelegate: class {
    func imeiResultCard(_ version: IMEIResultCard, didCopy imei: String)
}

class IMEIResultCard: UIView {
    var delegate: IMEIResultCardDelegate?
    
    private var scanResult: String = ""
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = self.scanResult.count == 15 ? self.scanResult : self.scanResult + "(Serial)"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    private lazy var btnCopy: UIButton = {
        let btn = UIButton()
        btn.shadowAndRadius()
        btn.setImage(UIImage(named: "ico_copy")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        btn.tintColor = UIColor.appBase
        btn.addTarget(self, action: #selector(copyAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    init(imei: String) {
        super.init(frame: .zero)
        self.scanResult = imei
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.label)
        self.addSubview(self.btnCopy)
        
        self.label.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.centerY.equalToSuperview()
            maker.trailing.equalTo(self.btnCopy.snp.leading)
            maker.height.greaterThanOrEqualTo(50)
            maker.top.bottom.equalToSuperview()
        }
        self.btnCopy.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().offset(-20)
            maker.width.height.greaterThanOrEqualTo(50)
            maker.centerY.equalToSuperview()
        }
    }
    
    @objc private func copyAction(_ sender: UIButton) {
        self.delegate?.imeiResultCard(self, didCopy: self.scanResult)
    }
}
