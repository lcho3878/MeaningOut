//
//  User.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

struct User {
    typealias key = UserDataKey
    
    @UserDefault(key: key.nickname.rawValue, defaultValue: nil, storage: .standard)
    static var nickname: String?
    
    @UserDefault(key: key.profileImageAssetName.rawValue, defaultValue: nil, storage: .standard)
    static var profileImageAssetName: String?
    
    static var profileImage: UIImage? {
        get {
            guard let profileImageAssetName else { return nil }
            return UIImage(named: profileImageAssetName)
        }
        set {
            guard let imageAssetName = newValue?.imageAsset?.value(forKey: "assetName") else { return }
            profileImageAssetName = imageAssetName as? String
        }
    }
    
    @UserDefault(key: key.signupDate.rawValue, defaultValue: nil, storage: .standard)
    static var signupDate: String?
    
    static var signupDateLabel: String {
        guard let signupDate else { return "가입"}
        return signupDate + "가입"
    }
    
    @UserDefault(key: key.searchList.rawValue, defaultValue: [:], storage: .standard)
    static var searchList: [String: Date]
    
    @UserDefault(key: key.wishList.rawValue, defaultValue: [:], storage: .standard)
    static var wishList: [String: Bool]
    
    static var wishListCountLabelText: NSAttributedString {
        let string = "\(wishList.count)개"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: Constant.FontSize.titleBold, range: NSRange(location: 0, length: string.count))
        let subString = NSAttributedString(string: "의 상품")
        attributedString.append(subString)
        return attributedString
    }
    
    static func updateWishList(_ productId: String?) {
        guard let productId else { return }
        if User.wishList[productId] != nil {
            User.wishList.removeValue(forKey: productId)
        }
        else {
            User.wishList[productId] = true
        }
    }
    
    static func resetUserDate() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    enum UserDataKey: String {
        case nickname
        case profileImageAssetName
        case signupDate
        case searchList
        case wishList
    }
}
