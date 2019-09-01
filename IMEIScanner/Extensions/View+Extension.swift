//
//  View+Extension.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shadowAndRadius(cornerRadius: CGFloat = 5, shadowRadius: CGFloat = 5) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = cornerRadius
    }
}
