//
//  HomeViewCell.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 20/08/19.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    private lazy var boundView: UIView = {
        let bound = UIView()
        bound.backgroundColor = .clear
        return bound
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.font = UIFont.sfuiMedium()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var iconSize: CGFloat {
        return UIScreen.main.scale == 2 ? 38 : 40
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: HomeCellModel) {
        self.imageView.image = model.image
        self.imageView.tintColor = UIColor.appBase
        self.label.text = model.title
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.placeHoder.cgColor
        self.layer.borderWidth = 0.5
        self.addSubview(self.boundView)
        
        self.boundView.addSubview(self.imageView)
        self.boundView.addSubview(self.label)
        
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(iconSize)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().priority(.medium)
        }
        
        self.label.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(8)
            make.height.greaterThanOrEqualTo(0)
            make.bottom.equalToSuperview().priority(.medium)
            make.left.right.equalToSuperview().priority(.medium)
        }
        
        self.boundView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}
