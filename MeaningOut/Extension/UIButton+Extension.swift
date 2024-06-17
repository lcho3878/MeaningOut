//
//  UIButton+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/17/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func orangeButton(buttonType: Constant.ButtonType) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        let container = AttributeContainer([.font: Constant.FontSize.titleBold])
        configuration.attributedTitle = AttributedString(buttonType.rawValue, attributes: container)
        configuration.baseBackgroundColor = Constant.AppColor.orange
        configuration.cornerStyle = .dynamic
        configuration.background.cornerRadius = 25
        return configuration
    }
    
    static func grayButton(buttonType: Constant.FilterButtonType) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = buttonType.rawValue
        configuration.baseForegroundColor = Constant.AppColor.black
        configuration.baseBackgroundColor = Constant.AppColor.white
        let container = AttributeContainer([.font: Constant.FontSize.content])
        configuration.attributedTitle = AttributedString(buttonType.rawValue, attributes: container)
        configuration.background.strokeColor = Constant.AppColor.black
        configuration.background.strokeWidth = 1
        configuration.background.cornerRadius = 15
        return configuration
    }
    
}
