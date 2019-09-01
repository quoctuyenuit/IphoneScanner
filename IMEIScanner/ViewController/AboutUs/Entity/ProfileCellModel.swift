//
//  ProfileCellModel.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/19/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

enum AboutUsCellType: String, CaseIterable {
    case header = "EXShop"
    case taoden = "Kiểm tra IMEI: taoden.vn"
    case phoneNumber1 = "SĐT: 0908.598.597"
    case phoneNumber2 = "SĐT: 0967.609.909"
    case footer = "Hệ thống dịch vụ sữa chữa Apple"
    
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
        self.title = type.rawValue
        self.subtitle = "exshop.vn"
    }
    
    func openUrlItem() {
        guard let url = URL(string: self.type.url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
