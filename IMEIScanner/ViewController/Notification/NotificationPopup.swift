//
//  NotificationPopup.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/10/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class NotificationPopup: UIViewController {
    private var showDuration: TimeInterval = 1
    private var msg: String?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.msg
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColorRGB(red: 41, green: 43, blue: 54, alpha: 0.7)
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateKeyframes(withDuration: self.showDuration, delay: 0, options: UIView.KeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                self.view.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: self.showDuration - 0.1, relativeDuration: self.showDuration, animations: {
                self.view.alpha = 0
            })
        }) { (flag) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    convenience init(msg: String, duration: TimeInterval = 1) {
        self.init(nibName: nil, bundle: nil)
        self.msg = msg
        self.showDuration = duration
        self.setupView()
        self.view.isUserInteractionEnabled = false
        self.modalPresentationStyle = .overFullScreen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.addSubview(self.mainContainerView)
        self.mainContainerView.addSubview(self.label)
        
        self.label.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.greaterThanOrEqualTo(100)
            maker.height.greaterThanOrEqualTo(50)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        self.mainContainerView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.lessThanOrEqualTo(self.view.snp.width).dividedBy(1.5)
        }
    }
    
    func show(from vc: UIViewController) {
        vc.present(self, animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: false, completion: nil)
    }
}
