//
//  IMEI.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 8/31/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class IMEI: Equatable {
    static func == (lhs: IMEI, rhs: IMEI) -> Bool {
        return lhs.imei == rhs.imei
    }
    
    var imei: String
    var note: String
    
    init(imei: String, note: String = "") {
        self.imei = imei
        self.note = note
    }
    
    func toString() -> String {
        return imei + "\n" + note
    }
}
