//
//  GuideLineViewController.swift
//  IMEIScanner
//
//  Created by Quoc Tuyen on 8/23/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit

class GuideLineViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelSubtitle1: UILabel!
    @IBOutlet weak var labelSubtitle2: UILabel!
    @IBOutlet weak var labelSubtitle3: UILabel!
    @IBOutlet weak var labelSubtitle4: UILabel!
    
    @IBOutlet weak var guideContent1_1: UILabel!
    @IBOutlet weak var guideContent1_2: UILabel!
    @IBOutlet weak var guideContent1_3: UILabel!
    
    @IBOutlet weak var guideContent2_1: UILabel!
    
    @IBOutlet weak var guideContent3_1: UILabel!
    
    @IBOutlet weak var guideContent4_1: UILabel!
    
    @IBOutlet weak var imageContent1_1: UIImageView!
    @IBOutlet weak var imageContent1_2: UIImageView!
    @IBOutlet weak var imageContent2_1: UIImageView!
    @IBOutlet weak var imageContent2_2: UIImageView!
    @IBOutlet weak var imageContent4_1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLocale()
    }
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        self.updateLocale()
    }
    
    private func updateLocale() {
        self.navigationItem.title = LocalizationHelper.shared.localized(LocalizationKeys.TITLE_GUIDE)
        self.labelTitle.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_TITLE)
        self.labelSubtitle1.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_SUBTITLE1)
        self.labelSubtitle2.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_SUBTITLE2)
        self.labelSubtitle3.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_SUBTITLE3)
        self.labelSubtitle4.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_SUBTITLE4)
        
        self.guideContent1_1.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT1_1)
        self.guideContent1_2.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT1_2)
        self.guideContent1_3.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT1_3)
        self.guideContent2_1.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT2_1)
        self.guideContent3_1.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT3_1)
        self.guideContent4_1.text = LocalizationHelper.shared.localized(LocalizationKeys.GUIDE_CONTENT4_1)
        
        self.imageContent1_1.image = LocalizationHelper.shared.localizedImage(LocalizationKeys.guide_manually_detected)
        self.imageContent1_2.image = LocalizationHelper.shared.localizedImage(LocalizationKeys.guide_manually)
        self.imageContent2_1.image = LocalizationHelper.shared.localizedImage(LocalizationKeys.guide_automatic)
        self.imageContent2_2.image = LocalizationHelper.shared.localizedImage(LocalizationKeys.guide_automatic_detected)
        self.imageContent4_1.image = LocalizationHelper.shared.localizedImage(LocalizationKeys.guide_settings)
    }
}
