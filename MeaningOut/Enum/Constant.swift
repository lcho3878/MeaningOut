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
        
        static let orangeBorder = UIColor(hexCode: "EF8947", alpha: 0.5)
        static let blackBorder = UIColor(hexCode: "000000", alpha: 0.5)
        static let whiteBorder = UIColor(hexCode: "FFFFFF", alpha: 0.5)
        static let lightGrayBorder = UIColor(hexCode: "CDCDCD", alpha: 0.5)
        static let middleGrayBorder = UIColor(hexCode: "828282", alpha: 0.5)
        static let heavyGrayBorder = UIColor(hexCode: "4C4C4C", alpha: 0.5)
    }
    
    enum ProfileImageUI {
        case main
        case select
        case notSelect
        
        var showdowOpacity: Float {
            switch self {
            case .select, .main:
                return 1
            case .notSelect:
                return 0.5
            }
        }
        
        var borderColor: CGColor {
            switch self {
            case .select, .main:
                return AppColor.orange.cgColor
            case .notSelect:
                return AppColor.lightGrayBorder.cgColor
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .select, .main:
                return 3
            case .notSelect:
                return 1
            }
        }
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
                guard User.nickanme != nil else { return "'s MEANING OUT"}
                return "\(User.nickanme!)'s MEANING OUT"
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
    
    enum NicknameValid {
        case correct
        case nicknameLength
        case containSpecial
        case containNumber
        
        var validResult: String {
            switch self {
            case .correct:
                return "사용할 수 있는 닉네임이에요"
            case .nicknameLength:
                return "2글자 이상 10글자 미만으로 설정해주세요"
            case .containSpecial:
                return "닉네임에 @, #, $, %은 포함할 수 없어요"
            case .containNumber:
                return "닉네임에 숫자는 포함할 수 없어요"
            }
        }
    }
    
    enum SettingMenu: String, CaseIterable {
        case wishList = "나의 장바구니 목록"
        case faq = "자주 묻는 질문"
        case inquiry = "1:1 문의"
        case alert = "알림 설정"
        case secession = "탈퇴하기"
    }
}

struct ProfileImage {
    static let profileImages = (0...11).compactMap { UIImage(named: "profile_\($0)") }
}

struct User {
    
    static var nickanme: String? {
        
        get{
            guard let nickname = UserDefaults.standard.string(forKey: "nickname") else {
                return nil
            }
            return nickname
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
        
    }
    
    static var profileImage: UIImage? {
        
        get {
            guard let imageAssetName = UserDefaults.standard.string(forKey: "profileImageAssetName") else { return nil }
            return UIImage(named: imageAssetName)
        }
        
        set {
            guard let imageAssetName = newValue?.imageAsset?.value(forKey: "assetName") else { return }
            UserDefaults.standard.set(imageAssetName, forKey: "profileImageAssetName")
        }
    }
}
