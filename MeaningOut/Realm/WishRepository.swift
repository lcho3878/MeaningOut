//
//  WishRepository.swift
//  MeaningOut
//
//  Created by 이찬호 on 7/7/24.
//

import UIKit
import CoreData

final class WishRepository {
    static let shared = WishRepository()
    
    private init() {}
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error \(error)")
        }
    }
    
    func fetchWishItems() -> [WishItem] {
        do {
            let wishItems = try context.fetch(WishItem.fetchRequest()) as! [WishItem]
            return wishItems
        } catch {
            return []
        }
    }
    
    func readWishItem(_ productId: String) -> WishItem? {
        let fetchRequest = WishItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productId == \(productId)", productId)
        do {
            guard let result = try context.fetch(fetchRequest).first else { return nil }
            return result
        } catch {
            return nil
        }
    }
    
    func addItem(_ data: Shopping) {
        if let entity = NSEntityDescription.entity(forEntityName: "WishItem", in: context) {
            let wishItem = NSManagedObject(entity: entity, insertInto: context)
            wishItem.setValue(data.brand, forKey: "brand")
            wishItem.setValue(data.image, forKey: "imageUrl")
            wishItem.setValue(data.link, forKey: "link")
            wishItem.setValue(data.maker, forKey: "maker")
            wishItem.setValue(data.mallName, forKey: "mallName")
            wishItem.setValue(data.price, forKey: "price")
            wishItem.setValue(data.productId, forKey: "productId")
            wishItem.setValue(data.cleanTitle, forKey: "title")
        }
        saveContext()
    }
    
    func deleteItem(_ wishItem: WishItem) {
        context.delete(wishItem)
        saveContext()
    }
    
    func updateWishList(_ data: Shopping) {
        if data.isLike {
            addItem(data)
        }
        else {
            if let wishItem = readWishItem(data.productId) {
                deleteItem(wishItem)
            }
        }
    }
}
