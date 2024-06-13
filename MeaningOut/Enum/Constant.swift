//
//  Constant.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

enum Constant {
    
    enum AppColor {
        static let orange = UIColor(hexCode: "EF8947")
        static let black = UIColor(hexCode: "000000")
        static let white = UIColor(hexCode: "FFFFFF")
        static let lightGray = UIColor(hexCode: "CDCDCD")
        static let middleGray = UIColor(hexCode: "828282")
        static let heavyGray = UIColor(hexCode: "4C4C4C")
    }
    
    enum ButtonType: String {
        case start = "시작하기"
        case complete = "완료"
    }
    
    enum TextFieldType: String {
        case nickname = "닉네임을 입력해주세요 :)"
        case search
    }
    
    enum FontSize {
        static let title = UIFont.systemFont(ofSize: 16)
        static let titleBold = UIFont.boldSystemFont(ofSize: 16)
        static let content = UIFont.systemFont(ofSize: 14)
        static let contentBold = UIFont.boldSystemFont(ofSize: 14)
        static let subtTitle = UIFont.systemFont(ofSize: 13)
        static let subtTitleBold = UIFont.boldSystemFont(ofSize: 13)
    }
    
    enum ViewType: String {
        case profileSetting
        case main
        case setting
        case search
        case result
        case profileEdit
        
        var navigationTitle: String {
            switch self {
            case .profileSetting:
                return "PROFILE SETTING"
            case .main:
                return "'s MEANING OUT"
            case .setting:
                return "SETTING"
            case .search:
                return ""
            case .result:
                return ""
            case .profileEdit:
                return "EDIT PROFILE"
            }
        }
    }
    
}
