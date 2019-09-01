//
//  AboutUsRouter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class AboutUsRouter: AboutUsRouterProtocol {
    class func createAboutUsViewController() -> UIViewController {
        let view = AboutUsViewController()
        let presenter = AboutUsPresenter()
        let interactor = AboutUsInteractor()
        let router = AboutUsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
