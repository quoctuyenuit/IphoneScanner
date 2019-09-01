//
//  HistoryProtocol.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/22/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol HistoryViewProtocol: class {
    var presenter: HistoryPresenterProtocol? { get set }
}

protocol HistoryPresenterProtocol: class {
    var router: HistoryRouterProtocol? { get set }
    var view: HistoryViewProtocol? { get set }
    
    func getItems() -> [IMEI]
}

protocol HistoryRouterProtocol: class {
    static func mainStoryboard() -> UIStoryboard
    static func createHistoryViewController() -> UIViewController
}
