//
//  HomePresenter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func getItems() -> [HomeCellModel] {
        return [
            HomeCellModel(identify: .manually, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_AUTOMATIC_SCAN)),
            HomeCellModel(identify: .automaticlly, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_AUTOMATIC_SCAN)),
            HomeCellModel(identify: .aboutUs, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_CONTACT)),
            HomeCellModel(identify: .guideLine, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_GUIDE)),
            HomeCellModel(identify: .unlockIphone, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_UNLOCK_IPHONE)),
            HomeCellModel(identify: .checkImei, title: LocalizationHelper.shared.localized(LocalizationKeys.HOME_CHECK_IMEI)),
        ]
    }
}
