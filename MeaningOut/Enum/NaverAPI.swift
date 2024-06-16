//
//  APIParameters.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/16/24.
//

import Foundation
import Alamofire

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
    
    static func callRequest(query: String, sort: String, display: Int, start: Int, completion: @escaping (ShoppingResult?, AFError?) -> Void) {
        guard let url = URL(string: NaverAPI.ParamInfoItem.shoppingURL) else { return }
        let param: Parameters = [
            NaverAPI.ParamInfoItem.query.rawValue: query,
            NaverAPI.ParamInfoItem.sort.rawValue: sort,
            NaverAPI.ParamInfoItem.display.rawValue: display,
            NaverAPI.ParamInfoItem.start.rawValue: start
        ]
        let headers: HTTPHeaders = [
            NaverAPI.HeaderInfoItem.clientID.rawValue: APIKey.clientId,
            NaverAPI.HeaderInfoItem.secretKey.rawValue: APIKey.clientSecret
        ]
        AF.request(url, parameters: param,headers: headers).responseDecodable(of: ShoppingResult.self) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
