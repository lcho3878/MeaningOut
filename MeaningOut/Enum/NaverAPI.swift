//
//  APIParameters.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/16/24.
//

import Foundation

enum NaverAPI {
    enum ParamInfoItem: String {
        static let shoppingURL = "https://openapi.naver.com/v1/search/shop.json"
        case query
        case sort
        case display
        case start
        
    }
    
    enum HeaderInfoItem: String {
        case clientID = "X-Naver-Client-id"
        case secretKey = "X-Naver-Client-Secret"
    }
    
}
