//
//  LocalizationHelper.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 9/1/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class LocalizationHelper {
    static let shared = LocalizationHelper()
    
    func localized(_ key: LocalizationKeys) -> String {
        return key.rawValue.localized(Preferences.shared.currentLocale())
    }
    
    func localized(_ key: String) -> String {
        return key.localized(Preferences.shared.currentLocale())
    }
}
