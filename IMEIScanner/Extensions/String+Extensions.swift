//
//  String+Extensions.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/5/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func replaceMatches(pattern: String, with replaceString: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let modString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceString)
        return modString
    }
    
    func localized(_ lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
