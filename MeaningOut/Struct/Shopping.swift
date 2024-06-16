//
//  Shopping.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import Foundation

struct Shopping: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
    var isLike: Bool {
        guard let isLike = User.wishList[productId] else { return false }
        return isLike
    }
    
    var cleanTitle: String {
        var cleanTitle = title
        cleanTitle = cleanTitle.replacingOccurrences(of: "<b>", with: "")
        cleanTitle = cleanTitle.replacingOccurrences(of: "</b>", with: "")
        return cleanTitle
    }
    
    var price: String {
        guard let price = Int(lprice) else { return ""}
        return "\(price.formatted())원"
    }
}

struct ShoppingResult: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Shopping]
    
    var totlaResult: String {
        return "\(total.formatted())개의 검색 결과"
    }

}
