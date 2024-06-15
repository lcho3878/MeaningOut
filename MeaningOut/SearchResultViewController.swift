//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

import Alamofire
import SnapKit

class SearchResultViewController: BaseViewController {
    
    var query: String!
    
    private var list: [Shopping] = []{
        didSet {
            resultCollectionView.reloadData()
        }
    }
    
    private let viewType = Constant.ViewType.result
    
    private let totalLabel = {
        let lb = UILabel()
        lb.text = "123,123개의 검색 결과"
        lb.textColor = Constant.AppColor.orange
        lb.font = Constant.FontSize.contentBold
        return lb
    }()
    
    private let button = FilterButton(buttonType: .sim)
    
    private let resultCollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        let verticalSpacing: CGFloat = 8
        let horizontalSpacing: CGFloat = 16
        let width = (UIScreen.main.bounds.width - 3 * horizontalSpacing) / 2
        let height = (UIScreen.main.bounds.height - 2 * verticalSpacing) / 3
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = verticalSpacing
        layout.minimumInteritemSpacing = horizontalSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing , bottom: verticalSpacing, right: horizontalSpacing)
        return layout
    }()
    
    private lazy var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: resultCollectionViewLayout)

    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest(query)
        configureCollectionView()
    }

    override func configureNavigationItem() {
        navigationItem.title = query
    }
    
    override func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(button)
        view.addSubview(resultCollectionView)
    }
    
    override func configureLayout() {
        
        totalLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(8)
            $0.leading.equalTo(totalLabel)
            $0.height.equalTo(30)
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
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
//                dump(value)
                self.list = value.items
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        let data = list[indexPath.row]
        cell.configureData(data)
        return cell
        
        
    }
    
    
    
}
