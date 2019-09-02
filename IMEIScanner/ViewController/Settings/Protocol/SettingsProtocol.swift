//
//  SettingsProtocol.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol? { get set }
}

protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    
    func createSetLanguageViewController() -> UIViewController?
    func setLanguage(for language: Languages)
    func getCurrentLanguage() -> Languages
    func getAllLanguages() -> [Languages]
}

protocol SettingsRouterProtocol: class{
    static func mainStoryboard() -> UIStoryboard
    static func createSettingsViewController() -> UIViewController?
    
    func createSetLanguageViewController() -> UIViewController?
}
