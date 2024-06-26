//
//  User.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

struct User {
    typealias key = UserDataKey
    
    static var nickanme: String? {
        get {
            guard let nickname = UserDefaults.standard.string(forKey: key.nickname.rawValue) else {
                return nil
            }
            return nickname
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.nickname.rawValue)
        }
    }
    
    static var profileImage: UIImage? {
        get {
            guard let imageAssetName = UserDefaults.standard.string(forKey: key.profileImageAssetName.rawValue) else { return nil }
            return UIImage(named: imageAssetName)
        }
        set {
            guard let imageAssetName = newValue?.imageAsset?.value(forKey: "assetName") else { return }
            UserDefaults.standard.set(imageAssetName, forKey: key.profileImageAssetName.rawValue)
        }
    }
    
    static var signupDate: String? {
        get {
            guard let signupDate = UserDefaults.standard.string(forKey: key.signupDate.rawValue) else {
                return nil
            }
            return signupDate + " 가입"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.signupDate.rawValue)
        }
    }
    
    static var searchList: [String: Date] {
        get {
            guard let searchList = UserDefaults.standard.value(forKey: key.searchList.rawValue) as? [String: Date] else { return [:] }
            return searchList
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.searchList.rawValue)
        }
    }
    
    static var wishList: [String: Bool] {
        get {
            guard let wishList = UserDefaults.standard.dictionary(forKey: key.wishList.rawValue) as? [String: Bool] else { return [:] }
            return wishList
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.wishList.rawValue)
        }
    }
    
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
