//
//  File.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 20/08/19.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

enum HomeCellIdentify {
    case manually
    case automaticlly
    case settings
    case guideLine
    case aboutUs
    case unlockIphone
    case checkImei
    
    var icon: UIImage? {
        switch self {
        case .manually:
            return UIImage(named: "ico_manually")?.withRenderingMode(.alwaysTemplate)
        case .automaticlly:
            return UIImage(named: "ico_automatic")?.withRenderingMode(.alwaysTemplate)
        case .settings:
            return UIImage(named: "ico_settings")?.withRenderingMode(.alwaysTemplate)
        case .guideLine:
            return UIImage(named: "ico_guideline")?.withRenderingMode(.alwaysTemplate)
        case .aboutUs:
            return UIImage(named: "ico_aboutus")?.withRenderingMode(.alwaysTemplate)
        case .unlockIphone:
            return UIImage(named: "ico_unlock")?.withRenderingMode(.alwaysTemplate)
        case .checkImei:
            return UIImage(named: "ico_check")?.withRenderingMode(.alwaysTemplate)
        }
        
    }
}

struct HomeCellModel {
    var identify: HomeCellIdentify
    var image: UIImage?
    var title: String
    
    init(identify: HomeCellIdentify, title: String) {
        self.identify = identify
        self.title = title
        self.image = identify.icon
    }
}
