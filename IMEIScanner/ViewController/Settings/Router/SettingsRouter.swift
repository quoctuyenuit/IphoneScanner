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
        guard let view = mainStoryboard().instantiateInitialViewController() as? SettingsViewProtocol & UIViewController else {
            return UIViewController()
        }
        
        let presenter: SettingsPresenterProtocol = SettingsPresenter()
        let router: SettingsRouterProtocol = SettingsRouter()
        
        view.presenter = presenter
        presenter.router = router
        
        return view
//        return UINavigationController(rootViewController: view)
    }
    
    func createSetLanguageViewController() -> UIViewController? {
        guard let view = UIStoryboard(name: "SetLanguage", bundle: nil).instantiateInitialViewController() as? SettingsViewProtocol & UIViewController else {
            return UIViewController()
        }
        
        let presenter: SettingsPresenterProtocol = SettingsPresenter()
        let router: SettingsRouterProtocol = SettingsRouter()
        
        view.presenter = presenter
        presenter.router = router
        
        return view
    }
}
