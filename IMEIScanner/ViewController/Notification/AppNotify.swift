//
//  AppNotify.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 8/31/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

final class AppNotify {
    static func show(for msg: String, from vc: UIViewController, duration: TimeInterval? = nil) {
        let notify = NotificationPopup(msg: msg, duration: duration ?? 1)
        vc.present(notify, animated: true, completion: nil)
    }
    
    static func copySuccessful(from vc: UIViewController) {
        show(for: LocalizationHelper.shared.localized(Localizations.NOTI_COPY_SUCCESS_MSG), from: vc)
    }
    
    static func scanFail(from vc: UIViewController) {
        show(for: LocalizationHelper.shared.localized(Localizations.NOTI_SCAN_FAILT), from: vc)
    }
}
