//
//  ShowResultsPresenter.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/7/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation


class ShowResultsPresenter: ShowResultsPresenterProtocol {
    var view: ShowResultsViewProtocol?
    var interactor: ShowResultsInteractorProtocol?
    var router: ShowResultsRouterProtocol?
}
