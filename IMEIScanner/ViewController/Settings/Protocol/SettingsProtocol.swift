//
//  SettingsProtocol.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewProtocol {
    
}

protocol SettingsRouterProtocol: class{
    static func mainStoryboard() -> UIStoryboard
    static func createSettingsViewController() -> UIViewController?
}
