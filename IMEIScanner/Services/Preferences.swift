//
//  Preferences.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 9/1/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class Preferences {
    
    private static let kCurrentLocale = "CurrentLocale"
    private static let kDefaultLocale = Languages.en.rawValue
    
    static let shared = Preferences()
    
    func currentLocale() -> String {
        if let locale = UserDefaults.standard.value(forKey: Preferences.kCurrentLocale) {
            return locale as! String
        }
        return Preferences.kDefaultLocale
    }
    
    func setCurrentLocale(_ locale: Languages) {
        UserDefaults.standard.set(locale.rawValue, forKey: Preferences.kCurrentLocale)
        UserDefaults.standard.synchronize()
    }
}
