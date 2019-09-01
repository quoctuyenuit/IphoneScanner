//
//  ProfilePresenter.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

class AboutUsPresenter: AboutUsPresenterProtocol {
    var view: AboutUsViewProtocol?
    var interactor: AboutUsInteractorProtocol?
    var router: AboutUsRouterProtocol?
    
    func getNumberOfRows() -> Int {
        return 2
    }
    
    func getListItems() -> [ProfileCellModel] {
        var items = [ProfileCellModel]()
        
        for type in AboutUsCellType.allCases {
            items.append(ProfileCellModel(type: type))
        }
        
        return items
    }
}
