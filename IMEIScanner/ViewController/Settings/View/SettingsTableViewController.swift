//
//  SettingsTableViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, SettingsViewProtocol {

    var parentVC: UIViewController?
    
    var presenter: SettingsPresenterProtocol?
    
    struct Constraints {
        static let AUTO_COPY_IDENTIFIER = "auto_copy"
        static let LANGUAGE_IDENTIFIER = "languages"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isAutoCopy = SettingsGlobal.isAutoCopy
        self.sw_autoCopy.setOn(self.isAutoCopy, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.updateLocale()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    private var isAutoCopy: Bool = false {
        willSet {
            SettingsGlobal.isAutoCopy = newValue
        }
    }
    
    @IBOutlet weak var languageTitle: UILabel!
    @IBOutlet weak var languageDetail: UILabel!
    @IBOutlet weak var autoCopyTitle: UILabel!
    @IBOutlet weak var sw_autoCopy: UISwitch!
    
    @IBAction func switchAutoCopyAction(_ sender: Any) {
        self.isAutoCopy = self.sw_autoCopy.isOn
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedIndex = self.tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        switch selectedIndex {
        case 0:
            self.isAutoCopy = !self.isAutoCopy
            self.sw_autoCopy.setOn(self.isAutoCopy, animated: true)
        case 1:
            guard let view = self.presenter?.createSetLanguageViewController() else {
                return
            }
            self.parentVC?.navigationController?.pushViewController(view, animated: true)
        default:
            return
        }
    }
    
    private func updateLocale() {
        self.navigationItem.title = LocalizationHelper.shared.localized(LocalizationKeys.TITLE_SETTINGS)
        self.autoCopyTitle.text = LocalizationHelper.shared.localized(LocalizationKeys.SETTING_AUTO_COPY)
        self.languageTitle.text = LocalizationHelper.shared.localized(LocalizationKeys.SETTING_LANGUAGE)
        self.languageDetail.text = LocalizationHelper.shared.localized(Preferences.shared.currentLocale())
    }
}
