//
//  GuideLineRouter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/22/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class GuideLineRouter {
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "GuideLine", bundle: nil)
    }
    
    static func createGuidelineViewController() -> UIViewController? {
        let viewController = mainStoryboard().instantiateInitialViewController()
        return viewController
    }
}
