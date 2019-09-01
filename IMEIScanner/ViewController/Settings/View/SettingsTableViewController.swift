//
//  SettingsTableViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/20/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isAutoCopy = SettingsGlobal.isAutoCopy
        self.sw_autoCopy.setOn(self.isAutoCopy, animated: false)
        self.navigationItem.title = "Cài đặt"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    private var isAutoCopy: Bool = false {
        willSet {
            SettingsGlobal.isAutoCopy = newValue
        }
    }
    
    @IBOutlet weak var sw_autoCopy: UISwitch!
    @IBAction func switchAutoCopyAction(_ sender: Any) {
        self.isAutoCopy = self.sw_autoCopy.isOn
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isAutoCopy = !self.isAutoCopy
        self.sw_autoCopy.setOn(self.isAutoCopy, animated: true)
    }
}
