//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import Alamofire

class SearchResultViewController: BaseViewController {
    
    var query: String!
    
    private let viewType = Constant.ViewType.result

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest(query)
    }

    override func configureNavigationItem() {
        navigationItem.title = query
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
    private func callRequest(_ query: String) {
        guard let url = URL(string: APIKey.shoppingURL) else { return }
        let param: Parameters = [
            "query": query
        ]
        let headers: HTTPHeaders = [
            "X-Naver-Client-id": APIKey.clientId,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        AF.request(url, parameters: param,headers: headers).responseDecodable(of: ShoppingResult.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
