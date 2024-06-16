//
//  User.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

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
    
    static var signupDate: String? {
        get {
            guard let signupDate = UserDefaults.standard.string(forKey: "signupDate") else {
                return nil
            }
            return signupDate + " 가입"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "signupDate")
        }
    }
    
    static var searchList: [String] {
        get {
            guard let searchList = UserDefaults.standard.array(forKey: "searchList") as? [String] else { return [] }
            return searchList
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchList")
        }
    }
    
    static var wishList: [String: Bool] {
        get {
            guard let wishList = UserDefaults.standard.dictionary(forKey: "wishList") as? [String: Bool] else { return [:] }
            return wishList
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wishList")
        }
    }
    
    static func updateWishList(_ productId: String?) {
        guard let productId else { return }
        if let isLike = User.wishList[productId] {
            User.wishList.removeValue(forKey: productId)
        }
        else {
            User.wishList[productId] = true
        }
    }
}
