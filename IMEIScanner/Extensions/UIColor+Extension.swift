//
//  UIColor+Extension.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/8/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func createColorRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return self.init(red: red / 255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    public static var appBase: UIColor {
        return UIColor.init(red: 66/255, green: 103/255, blue: 178/255, alpha: 1)
//        return UIColor.init(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    public static var background: UIColor {
        return UIColor.init(red: 244/255, green: 248/255, blue: 251/255, alpha: 1)
    }
    
    public static var placeHoder: UIColor {
        return UIColor.init(red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
    }
    
    public static var notifiTitle: UIColor {
        return .gray
    }
    
    public static var whiteTwo: UIColor {
        return UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
}
