//
//  ProfileHeaderViewCell.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderViewCell: UITableViewCell {
    
    public static let REUSE_IDENTIFIER = "ProfileHeaderViewCell"
    private let avatarSize: CGFloat = 100
    private lazy var _avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.backgroundColor = .white
        imageView.clearsContextBeforeDrawing = true
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.whiteTwo.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "default_avatar")
        return imageView
    }()
    
    private lazy var _nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        return label
    }()
    
    private lazy var _userTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.white
        return label
    }()
    
    private lazy var _moreContentView = UIView(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self._avatar)
        self.addSubview(self._moreContentView)
        
        self._moreContentView.addSubview(self._nameLabel)
        self._moreContentView.addSubview(self._userTypeLabel)
        
        self._avatar.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.width.height.equalTo(self.avatarSize)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        self._nameLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        self._userTypeLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(self._nameLabel.snp.bottom).offset(5)
        }
        
        self._moreContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self._avatar.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.centerY.equalToSuperview()
        }
    }
    
    public func setConfig(for model: ProfileCellModel) {
        if model.icon != nil {
            self._avatar.image = model.icon
        }
        self._nameLabel.text = model.title
        self._userTypeLabel.text = model.subtitle
    }

}
