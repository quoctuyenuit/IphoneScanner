//
//  ShowResultsRouter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class ShowResultsRouter: ShowResultsRouterProtocol {
    static func createShowResultViewController(imeisList: [String]) -> UIViewController {
        let view: UIViewController & ShowResultsViewProtocol = ShowResultsViewController(imeisList: imeisList)
        let presenter: ShowResultsPresenterProtocol = ShowResultsPresenter()
        let interactor: ShowResultsInteractorProtocol = ShowResultsInteractor()
        let router: ShowResultsRouterProtocol = ShowResultsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
