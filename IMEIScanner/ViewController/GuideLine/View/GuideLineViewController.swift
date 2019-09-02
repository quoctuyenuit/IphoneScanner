//
//  GuideLineViewController.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/23/19.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = LocalizationHelper.shared.localized(Localizations.TITLE_GUIDE)
        // Do any additional setup after loading the view.
    }
    
    private func updateLocale() {
        self.labelTitle.text = LocalizationHelper.shared.localized(Localizations.GUIDE_TITLE)
        self.labelSubtitle1.text = LocalizationHelper.shared.localized(Localizations.GUIDE_SUBTITLE1)
        self.labelSubtitle2.text = LocalizationHelper.shared.localized(Localizations.GUIDE_SUBTITLE2)
        self.labelSubtitle3.text = LocalizationHelper.shared.localized(Localizations.GUIDE_SUBTITLE3)
        self.labelSubtitle4.text = LocalizationHelper.shared.localized(Localizations.GUIDE_SUBTITLE4)
        
        self.guideContent1_1.text = LocalizationHelper.shared.localized(Localizations.GUIDE_CONTENT1_1)
        self.guideContent1_2.text = LocalizationHelper.shared.localized(Localizations.GUIDE_CONTENT1_2)
        self.guideContent1_3.text = LocalizationHelper.shared.localized(Localizations.GUIDE_CONTENT1_3)
        
        self.guideContent2_1.text = LocalizationHelper.shared.localized(Localizations.GUIDE_CONTENT2_1)
        
        self.guideContent3_1.text = LocalizationHelper.shared.localized(Localizations.GUIDE_CONTENT3_1)
    }
}
