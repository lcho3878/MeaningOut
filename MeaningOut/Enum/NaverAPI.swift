//
//  APIParameters.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/16/24.
//

import Foundation
import Alamofire

class NaverAPIManager {
    
    private init () {}
    
    static let shared = NaverAPIManager()
    
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
    
    struct APIError: Decodable {
        let errorMessage: String
        let errorCode: String
        
        var errorType: ErrorType? {
            switch errorCode {
            case "SE01": return .incorectQuery
            case "SE02": return .invalidDisplay
            case "SE03": return .invalidStart
            case "SE04": return .invalidSort
            case "SE05": return .invalidAPI
            case "SE06": return .invalidEncoding
            case "SE99": return .systemError
            default: return nil
            }
        }
    }
    
    enum ErrorType: LocalizedError {
        case offline
        case incorectQuery
        case invalidDisplay
        case invalidStart
        case invalidSort
        case invalidEncoding
        case invalidAPI
        case systemError
        var errorDescription: String? {
            switch self {
            case .offline: return "네트워크가 원활하지 않습니다. 네트워크 연결을 확인해주세요."
            case .incorectQuery: return "잘못된 쿼리요청입니다. 검색어의 첫부분이 \"/, ., ^, !, #, %\"가 되지 않도록 해주세요"
            case .invalidDisplay: return "부적절한 display 값입니다. 개발자에게 오류를 신고해 주십시오."
            case .invalidStart: return "부적절한 start 값입니다. 개발자에게 오류를 신고해 주십시오."
            case .invalidSort: return "부적절한 sort 값입니다. 개발자에게 오류를 신고해 주십시오."
            case .invalidEncoding: return "잘못된 형식의 인코딩입니다. 개발자에게 오류를 신고해 주십시오."
            case .invalidAPI: return "존재하지 않는 검색 api 입니다. 개발자에게 오류를 신고해 주십시오."
            case .systemError: return "서버 내부에 오류가 발생했습니다. 개발자에게 오류를 신고해 주십시오."
            }
        }
    }

    func callRequest(query: String, sort: String, display: Int, start: Int, completion: @escaping (ShoppingResult?, ErrorType?) -> Void) {
        guard let url = URL(string: ParamInfoItem.shoppingURL) else { return }
        let param: Parameters = [
            ParamInfoItem.query.rawValue: query,
            ParamInfoItem.sort.rawValue: sort,
            ParamInfoItem.display.rawValue: display,
            ParamInfoItem.start.rawValue: start
        ]
        let headers: HTTPHeaders = [
            HeaderInfoItem.clientID.rawValue: APIKey.clientId,
            HeaderInfoItem.secretKey.rawValue: APIKey.clientSecret
        ]
        AF.request(url, parameters: param,headers: headers)
            .validate(statusCode: 200...200)
            .responseDecodable(of: ShoppingResult.self) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(_):
                guard (response.response?.statusCode) != nil else { 
                    completion(nil, ErrorType.offline)
                    return
                }
                guard let data = response.data,
                      let apiError = try? JSONDecoder().decode(APIError.self, from: data)   else { return }
                completion(nil, apiError.errorType)
            }
        }

    }
    
}
