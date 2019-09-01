//
//  HistoryTableViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/22/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryTableViewController: UITableViewController, HistoryViewProtocol {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var parentVC: UIViewController?
    var presenter: HistoryPresenterProtocol?
    let disposeBag = DisposeBag()
    
    var items: [IMEI] {
        guard let items = self.presenter?.getItems() else {
            return []
        }
        return items
    }
    
    lazy var shownItems: [IMEI] = items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Lịch sử"
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
//        self.tableView.addGestureRecognizer(tapGesture)
        
        self.searchBar
            .rx.text
            .orEmpty
            .debounce(RxTimeInterval.microseconds(50), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.shownItems = self.items.filter { $0.imei.hasPrefix(query) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadHistory()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.shownItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.REUSE_IDENTIFIER, for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let imei = self.items[indexPath.row]
        cell.config(for: imei)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        if let index = tableView.indexPathForSelectedRow {
            let imei = self.shownItems[index.row]
            let detail = HistoryDetailViewController()
            detail.config(for: imei)
            self.present(detail, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func reloadHistory() {
        self.searchBar.text = ""
        self.shownItems = items
        self.tableView.reloadData()
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        self.searchBar.endEditing(true)
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        self.searchBar.endEditing(true)
    }
}

extension HistoryTableViewController: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
