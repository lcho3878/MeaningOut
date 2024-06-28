//
//  PropertyWrapper+UserDefault.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/28/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    let storage: UserDefaults
    
    var wrappedValue: T {
        get { guard let wrappedValue = storage.object(forKey: key) as? T else { return defaultValue }
            return wrappedValue
        }
        set { storage.set(newValue, forKey: key) }
    }
}
