//
//  ShowResults.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol ShowResultsViewProtocol: class {
    var presenter: ShowResultsPresenterProtocol? { get set }
}

protocol ShowResultsPresenterProtocol: class {
    var view: ShowResultsViewProtocol? { get set }
    var interactor: ShowResultsInteractorProtocol? { get set }
    var router: ShowResultsRouterProtocol? { get set }
}

protocol ShowResultsInteractorProtocol: class {
    var presenter: ShowResultsPresenterProtocol? { get set }
}

protocol ShowResultsRouterProtocol: class {
    static func createShowResultViewController(imeisList: [String]) -> UIViewController
}
