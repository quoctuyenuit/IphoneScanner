//
//  SettingsPresenter.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 9/2/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class SettingsPresenter: SettingsPresenterProtocol {
    var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    
    func getAllLanguages() -> [Languages] {
        return Languages.allCases
    }
    
    func getCurrentLanguage() -> Languages {
        let currentLang = Preferences.shared.currentLocale()
        for lang in Languages.allCases {
            if lang.rawValue == currentLang {
                return lang
            }
        }
        
        return Languages.en
    }
    
    func createSetLanguageViewController() -> UIViewController? {
        return self.router?.createSetLanguageViewController()
    }
    
    func setLanguage(for language: Languages) {
        Preferences.shared.setCurrentLocale(language)
    }
}
