//
//  LocalizationHelper.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 9/1/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

let LangVie = "vie"
let LangEn = "en"
class LocalizationHelper {
    static let shared = LocalizationHelper()
    
    func localized(_ key: Localizations) -> String {
        
        switch Preferences.shared.currentLocale() {
        case LangVie:
            return key.vieMsg
        case LangEn:
            return key.enMsg
        default:
            return ""
        }
        
    }
}
