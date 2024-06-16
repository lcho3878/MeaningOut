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

class FilterButton: UIButton {
    
    override var isSelected: Bool{
        didSet {
            backgroundColor = isSelected ? Constant.AppColor.heavyGray : Constant.AppColor.white
            layer.borderColor = isSelected ? Constant.AppColor.white.cgColor : Constant.AppColor.black.cgColor
        }
    }
    
    init(buttonType: Constant.FilterButtonType) {
        super.init(frame: CGRect.zero)
        setTitle(buttonType.rawValue, for: .normal)
        setTitleColor(Constant.AppColor.black, for: .normal)
        setTitleColor(Constant.AppColor.white, for: .selected)
        titleLabel?.font = Constant.FontSize.content
        backgroundColor = Constant.AppColor.white
        layer.borderColor = Constant.AppColor.black.cgColor
        layer.borderWidth = 1
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
