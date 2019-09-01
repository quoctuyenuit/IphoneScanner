//
//  HistoryTableViewCell.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/23/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    static let REUSE_IDENTIFIER = "HistoryCell"
    
    @IBOutlet weak var copyButton: UIButton!
    
    @IBOutlet weak var imeiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.copyButton.setImage(UIImage(named: "ico_copy")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
//        self.copyButton.tintColor = UIColor.appBase
    }
    
    func config(for imei: IMEI) {
        self.imeiLabel.text = imei.imei
    }
}
