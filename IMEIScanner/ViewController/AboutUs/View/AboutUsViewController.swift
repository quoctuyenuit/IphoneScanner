//
//  ProfileViewController.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/18/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, AboutUsViewProtocol {

    var presenter: AboutUsPresenterProtocol?
    var parentView: UIViewController?
    
    private var _listItems: [ProfileCellModel] {
        return self.presenter?.getListItems() ?? []
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ProfileViewCell.self, forCellReuseIdentifier: ProfileViewCell.REUSE_IDENTIFIER)
        table.register(ProfileHeaderViewCell.self, forCellReuseIdentifier: ProfileHeaderViewCell.REUSE_IDENTIFIER)
        table.delegate = self
        table.dataSource = self
        table.separatorColor = UIColor.clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.updateLocale()
    }
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        self.updateLocale()
    }
    
    private func updateLocale() {
        self.navigationItem.title = LocalizationHelper.shared.localized(LocalizationKeys.TITLE_CONTACT)
        self.tableView.reloadData()
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension AboutUsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self._listItems[indexPath.row]
        
        switch item.type {
        case .header:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileHeaderViewCell.REUSE_IDENTIFIER) as! ProfileHeaderViewCell
            cell.setConfig(for: item)
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.REUSE_IDENTIFIER) as! ProfileViewCell
            cell.setConfig(for: item)
            return cell
        }
    }
}

extension AboutUsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let item = self._listItems[indexPath.row]

        if item.type == .phoneNumber1 || item.type == .phoneNumber2 {
            let phoneNumber = item.type.string.matches(for: "(\\d)").joined(separator: "")

            self.callNumber(phoneNumber: phoneNumber)
            
        } else {
            item.openUrlItem()
        }
        
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
