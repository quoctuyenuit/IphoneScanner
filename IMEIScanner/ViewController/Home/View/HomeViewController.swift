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
            HomeCellModel(identify: .manually, title: "Quét thủ công"),
            HomeCellModel(identify: .automaticlly, title: "Quét tự động"),
            HomeCellModel(identify: .aboutUs, title: "Liên hệ"),
            HomeCellModel(identify: .guideLine, title: "Hướng dẫn sử dụng"),
            HomeCellModel(identify: .settings, title: "Cài đặt"),
            HomeCellModel(identify: .unlockIphone, title: "Unlock iPhone"),
            HomeCellModel(identify: .checkImei, title: "Kiểm tra IMEI"),
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
        self.title = "Trang chủ"
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
