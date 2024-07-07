//
//  WishRepository.swift
//  MeaningOut
//
//  Created by 이찬호 on 7/7/24.
//

import Foundation
import RealmSwift

final class WishRepository {
    
    static let shared = WishRepository()
    
    private init() {}
    
    private let realm = try! Realm()
    
    func readItems() -> Results<Wish> {
        return realm.objects(Wish.self)
    }
    
    private func addItem(_ wish: Wish) {
        try! realm.write {
            realm.add(wish)
        }
    }
    
    private func deleteItem(_ key: String) {
        guard let wish = readItem(key) else { return }
        try! realm.write {
            realm.delete(wish)
        }
    }
    
    private func readItem(_ key: String) -> Wish? {
        return realm.object(ofType: Wish.self, forPrimaryKey: key)
    }
    
    func updateWishList(_ shopping: Shopping) {
        if shopping.isLike {
            let wish = Wish(shopping: shopping)
            addItem(wish)
        }
        else {
            deleteItem(shopping.productId)
        }
    }
}
