//
//  TabbarViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


fileprivate enum BarType {
    case home
    case history
    case setting
    var name: String {
        switch self {
        case .home:
            return LocalizationHelper.shared.localized(.TAB_HOME)
        case .history:
            return LocalizationHelper.shared.localized(.TAB_HISTORY)
        case .setting:
            return LocalizationHelper.shared.localized(.TAB_SETTING)
        }
    }
    var iconName: String {
        switch self {
        case .home:
            return "ico_home"
        case .history:
            return "ico_history"
        case .setting:
            return "ico_settings"
        }
    }
}

class TabBarViewController: UIViewController {
    
    private var viewControllers: [UIViewController] {
        return self.configure()
    }
    
    var tabBarViewController: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func updateLocale() {
        let home = self.tabBarViewController.viewControllers?[0]
        let history = self.tabBarViewController.viewControllers?[1]
        let setting = self.tabBarViewController.viewControllers?[2]
        
        home?.tabBarItem.title = BarType.home.name
        history?.tabBarItem.title = BarType.history.name
        setting?.tabBarItem.title = BarType.setting.name
        
        home?.onUpdateLocale()
        history?.onUpdateLocale()
        setting?.onUpdateLocale()
    }
    
    private func setupView() {
        self.tabBarViewController = UITabBarController()
        self.tabBarViewController.delegate = self
        self.tabBarViewController.viewControllers = self.viewControllers
        self.view.addSubview(self.tabBarViewController.view)
        self.tabBarViewController
            .view
            .snp
            .makeConstraints { make in
                make.edges.equalToSuperview()
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {}

extension TabBarViewController {
    fileprivate func createBarItem(with type: BarType) -> UITabBarItem {
        let image = UIImage(named: type.iconName)
        let item = UITabBarItem(title: type.name, image: image, selectedImage: image?.withRenderingMode(.alwaysTemplate))
        
        item.badgeValue = nil
        item.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -2.0)
        
        item.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setTitleTextAttributes([.foregroundColor: UIColor.appBase], for: .selected)
        
        item.setBadgeTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        item.setBadgeTextAttributes([.foregroundColor: UIColor.appBase], for: .selected)
        return item;
    }
    
    func configure() -> [UIViewController] {
        var tab:[UIViewController] = []
        let home = HomeRouter.createHomeViewController()
        home.tabBarItem = self.createBarItem(with: .home)
        tab.append(home)
            
        
        let history = HistoryRouter.createHistoryViewController()
        history.tabBarItem = self.createBarItem(with: .history)
        tab.append(history)
        
        if let setting = SettingsRouter.createSettingsViewController() {
            setting.tabBarItem = self.createBarItem(with: .setting)
            tab.append(setting)
        }
        
        return tab
    }
}
