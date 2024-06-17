//
//  OrangeButton.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit


class FilterButton: UIButton {
    
    init(buttonType: Constant.FilterButtonType) {
        super.init(frame: CGRect.zero)
        configuration = UIButton.Configuration.grayButton(buttonType: buttonType)
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            let isSelected = button.state == .selected
            self.configuration?.baseForegroundColor = isSelected ? Constant.AppColor.white : Constant.AppColor.black
            self.configuration?.baseBackgroundColor = isSelected ? Constant.AppColor.heavyGray : Constant.AppColor.white
            self.configuration?.background.strokeColor = isSelected ? Constant.AppColor.white : Constant.AppColor.black
        }
        configurationUpdateHandler = handler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
