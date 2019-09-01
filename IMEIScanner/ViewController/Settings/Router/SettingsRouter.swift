//
//  SettingsRouter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class SettingsRouter: SettingsRouterProtocol {
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "SettingsView", bundle: nil)
    }
    
    static func createSettingsViewController() -> UIViewController? {
        let viewController = mainStoryboard().instantiateInitialViewController()
        return viewController
    }
}
