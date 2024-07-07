//
//  Wish.swift
//  MeaningOut
//
//  Created by 이찬호 on 7/7/24.
//

import Foundation
import RealmSwift

final class Wish: Object {
    @Persisted(primaryKey: true) var productId: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var imageUrl: String
    @Persisted var price: String
    @Persisted var mallName: String
    @Persisted var brand: String
    @Persisted var maker: String
    
    convenience init(shopping: Shopping) {
        self.init()
        self.productId = shopping.productId
        self.title = shopping.cleanTitle
        self.link = shopping.link
        self.imageUrl = shopping.image
        self.price = shopping.lprice
        self.mallName = shopping.mallName
        self.brand = shopping.brand
        self.maker = shopping.maker
    }
    
}
