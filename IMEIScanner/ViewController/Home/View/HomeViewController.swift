//
//  HomeViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 20/08/19.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout
import Firebase

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    var parentView: UIViewController?
    
    //MARK: - Constant variable
    
    private lazy var items: [HomeCellModel] = {
        var items = [HomeCellModel]()
        items = [
            HomeCellModel(identify: .manually, title: LocalizationHelper.shared.localized(Localizations.HOME_MANUALLY_SCAN)),
            HomeCellModel(identify: .automaticlly, title: LocalizationHelper.shared.localized(Localizations.HOME_AUTOMATIC_SCAN)),
            HomeCellModel(identify: .aboutUs, title: LocalizationHelper.shared.localized(Localizations.HOME_CONTACT)),
            HomeCellModel(identify: .guideLine, title: LocalizationHelper.shared.localized(Localizations.HOME_GUIDE)),
            HomeCellModel(identify: .unlockIphone, title: LocalizationHelper.shared.localized(Localizations.HOME_UNLOCK_IPHONE)),
            HomeCellModel(identify: .checkImei, title: LocalizationHelper.shared.localized(Localizations.HOME_CHECK_IMEI)),
            HomeCellModel(identify: .settings, title: LocalizationHelper.shared.localized(Localizations.HOME_SETTINGS)),
        ]
        return items
    }()
    private var cellSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: width)
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewLeftAlignedLayout()
        // Now setup the flowLayout required for drawing the cells
        let space = 5.0 as CGFloat
        flowLayout.itemSize = cellSize
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.collectionView.indicatorStyle = .white
        self.title = LocalizationHelper.shared.localized(Localizations.TITLE_HOME)
    }
    
    private func setupView() {
        self.setupCollectionView()
        self.view.backgroundColor = .appBase
        
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func configure(items: [HomeCellModel]) {
        self.items = items
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        switch item.identify {
        case .manually:
            let scannerViewController = IMEIScannerRouter.createIMEIScannerView()
            self.parentView?.navigationController?.pushViewController(scannerViewController, animated: true)
        case .automaticlly:
            let view = IMEIScannerRouter.createIMEIScannerVideo()
            self.parentView?.navigationController?.pushViewController(view, animated: true)
        case .settings:
            let settingsView = SettingsRouter.createSettingsViewController()
            self.parentView?.navigationController?.pushViewController(settingsView!, animated: true)
        case .aboutUs:
            let aboutUsView = AboutUsRouter.createAboutUsViewController()
            self.parentView?.navigationController?.pushViewController(aboutUsView, animated: true)
        case .guideLine:
            let guidelineView = GuideLineRouter.createGuidelineViewController()
            self.parentView?.navigationController?.pushViewController(guidelineView!, animated: true)
        case .unlockIphone:
            guard let url = URL(string: "https://taoden.vn/") else {
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case .checkImei:
            guard let url = URL(string: "https://taoden.vn/") else {
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeViewCell else { return UICollectionViewCell() }
        let model = items[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
