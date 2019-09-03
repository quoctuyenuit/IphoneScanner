//
//  HistoryRouter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/22/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class HistoryRouter: HistoryRouterProtocol {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "HistoryStoryboard", bundle: nil)
    }
    
    class func createHistoryViewController() -> UIViewController {
        guard let view = mainStoryboard().instantiateInitialViewController() as? HistoryViewProtocol & UIViewController else {
            return UIViewController()
        }
        
        let presenter: HistoryPresenterProtocol = HistoryPresenter()
        let router: HistoryRouterProtocol = HistoryRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return UINavigationController(rootViewController: view)
    }
}
