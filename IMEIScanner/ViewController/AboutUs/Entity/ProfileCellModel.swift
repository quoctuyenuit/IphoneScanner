//
//  ProfileCellModel.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

enum AboutUsCellType: CaseIterable {
    case header
    case taoden
    case phoneNumber1
    case phoneNumber2
    case footer
    
    var string: String {
        switch self {
        case .header:
            return LocalizationHelper.shared.localized(Localizations.STORE_NAME)
        case .taoden:
            return LocalizationHelper.shared.localized(Localizations.TITLE_ACTION_SCAN)
        case .phoneNumber1:
            return LocalizationHelper.shared.localized(Localizations.CONTACT_PHONE_NUMBER1)
        case .phoneNumber2:
            return LocalizationHelper.shared.localized(Localizations.CONTACT_PHONE_NUMBER2)
        case .footer:
            return LocalizationHelper.shared.localized(Localizations.CONTACT_FOOTER)
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .header:
            return UIImage(named: "logo")
        default:
            return nil
        }
    }
    
    var url: String {
        switch self {
        case .header:
            return "https://exshop.vn/"
        case .taoden:
            return "https://taoden.vn/"
        default:
            return ""
        }
    }
}

struct ProfileCellModel {
    var icon: UIImage?
    var type: AboutUsCellType
    var title: String?
    var subtitle: String?
    
    init(type: AboutUsCellType) {
        self.type = type
        self.icon = type.icon
        self.title = type.string
        self.subtitle = "exshop.vn"
    }
    
    func openUrlItem() {
        guard let url = URL(string: self.type.url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
