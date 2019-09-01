//
//  IMEIScannerRouter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class IMEIScannerRouter: IMEIScannerRouterProtocol {
    static func createIMEIScannerView() -> UIViewController {
        var view: UIViewController & IMEIScannerViewProtocol = IMEIScannerViewController()
        var presenter: IMEIScannerPresenterProtocol? = IMEIScannerPresenter()
        var interactor: IMEIScannerInteractorProtocol? = IMEIScannerInteractor()
        let router: IMEIScannerRouterProtocol? = IMEIScannerRouter()
        let boxService: BoxServiceProtocol? = BoxService()
        
        
        view.presenter = presenter
        view.boxService = boxService
        
        presenter?.view = view
        presenter?.interactor = interactor
        presenter?.router = router
        
        interactor?.presenter = presenter
        
        return view
//        let navigationController = UINavigationController(rootViewController: view)
////        navigationController.setNavigationBarHidden(true, animated: false)
//        return navigationController
    }
    
    static func createIMEIScannerVideo() -> UIViewController {
        var view: UIViewController & IMEIScannerViewProtocol = IMEIScannerVideoController()
        var presenter: IMEIScannerPresenterProtocol? = IMEIScannerPresenter()
        var interactor: IMEIScannerInteractorProtocol? = IMEIScannerInteractor()
        let router: IMEIScannerRouterProtocol? = IMEIScannerRouter()
        let boxService: BoxServiceProtocol? = BoxService()
        
        
        view.presenter = presenter
        view.boxService = boxService
        
        presenter?.view = view
        presenter?.interactor = interactor
        presenter?.router = router
        
        interactor?.presenter = presenter
        
        return view
    }
    
    
}
