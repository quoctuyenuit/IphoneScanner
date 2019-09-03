//
//  SetLanguageTableViewController.swift
//  IMEIScanner
//
//  Created by QuocTuyen on 9/2/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class SetLanguageTableViewController: UITableViewController, SettingsViewProtocol {

    let identifier = "LanguageCell"
    var presenter: SettingsPresenterProtocol?
    var languages: [Languages] {
        return self.presenter?.getAllLanguages() ?? []
    }
    
    var currentLanguage: Languages {
        return self.presenter?.getCurrentLanguage() ?? Languages.en
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let lang = self.languages[indexPath.row]
        cell.textLabel?.text = LocalizationHelper.shared.localized(lang.rawValue)
        cell.accessoryType = .none
        
        if lang == self.currentLanguage {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndex = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        let currentCell = self.tableView.cellForRow(at: indexPath)
        self.tableView.visibleCells.forEach { $0.accessoryType = .none }
        currentCell?.accessoryType = .checkmark
        
        let currentLang = self.languages[selectedIndex]
        self.presenter?.setLanguage(for: currentLang)
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.popViewController(animated: true)
        
        guard let rootView = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            return
        }
        
        if let tabBar = rootView.topViewController as? TabBarViewController {
//            let selectedIndex = tabBar.tabBarViewController.selectedIndex
            tabBar.updateLocale()
//            tabBar.tabBarViewController.selectedIndex = selectedIndex
        }
       
    }
}
