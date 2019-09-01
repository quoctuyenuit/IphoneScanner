//
//  ViewController+Extension.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/6/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(childController: UIViewController) {
        childController.willMove(toParent: self)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
}

