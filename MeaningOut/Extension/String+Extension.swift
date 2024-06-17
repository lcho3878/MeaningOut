//
//  String+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/17/24.
//

import UIKit

extension String {
    
    static func getHilightedText(_ text: String, _ searchText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text.lowercased() as NSString).range(of: searchText.lowercased())
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: Constant.AppColor.white, range: range)
            attributedString.addAttribute(.backgroundColor, value: Constant.AppColor.orangeBorder, range: range)
            attributedString.addAttribute(.font, value: Constant.FontSize.content, range: range)
        }
        return attributedString
    }
    
}
