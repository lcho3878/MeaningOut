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
}

struct ShoppingResult: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Shopping]
}
