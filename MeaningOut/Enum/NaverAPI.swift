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
    
    static func callRequest(query: String, sort: String, display: Int, start: Int, completion: @escaping (ShoppingResult) -> Void) {
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
                completion(value)
            case .failure(let error):
                print(error)
            }
            
            //            case .success(let value):
            //                if self.start == 1 {
            //                    self.totalLabel.text = value.totlaResult
            //                    self.list = value.items
            //                    guard !self.list.isEmpty else { return }
            //                    self.resultCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top , animated: true)
            //                }
            //                else {
            //                    self.list.append(contentsOf: value.items)
            //                }
            //
            //            case .failure(let error):
            //                print(error)
        }
    }
}
