//
//  ProfileProtocol.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol AboutUsViewProtocol {
    var presenter: AboutUsPresenterProtocol? { get set }
}
protocol AboutUsPresenterProtocol {
    var view: AboutUsViewProtocol? { get set }
    var interactor: AboutUsInteractorProtocol? { get set }
    var router: AboutUsRouterProtocol? { get set }
    
    func getNumberOfRows() -> Int
    func getListItems() -> [ProfileCellModel]
}
protocol AboutUsInteractorProtocol {
    
}
protocol AboutUsRouterProtocol {
    static func createAboutUsViewController() -> UIViewController
}

