//
//  OrangeButton.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class OrangeButton: UIButton {
    
    init(buttonType: Constant.ButtonType) {
        super.init(frame: CGRect.zero)
        
        setTitle(buttonType.rawValue, for: .normal)
        backgroundColor = Constant.AppColor.orange
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
