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
    var name: String {
        switch self {
        case .home:
            return "Trang chủ"
        case .history:
            return "Lịch sử"
        }
    }
    var iconName: String {
        switch self {
        case .home:
            return "ico_home"
        case .history:
            return "ico_history"
        }
    }
}

class TabBarViewController: UIViewController {
    
    private lazy var viewControllers: [UIViewController] = {
        return self.configure()
    }()
    
    private var tabBarViewController: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.setupView()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .appBase
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        if let home = HomeRouter.createHomeViewController() as? HomeViewController {
            home.parentView = self
            home.tabBarItem = self.createBarItem(with: .home)
            tab.append(home)
        }
        
        if let history = HistoryRouter.createHistoryViewController() as? HistoryTableViewController {
            history.parentVC = self
            history.tabBarItem = self.createBarItem(with: .history)
            tab.append(history)
        }
        
        return tab
    }
}
