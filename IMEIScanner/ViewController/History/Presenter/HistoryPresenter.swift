//
//  HistoryPresenter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/22/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class HistoryPresenter: HistoryPresenterProtocol {
    var view: HistoryViewProtocol?
    var router: HistoryRouterProtocol?
    
    func getItems() -> [IMEI] {
        return SettingsGlobal.results
    }
}
