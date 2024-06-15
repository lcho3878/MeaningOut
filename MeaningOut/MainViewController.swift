//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    private let viewType = Constant.ViewType.main
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "브랜드, 상품등을 입력하세요"
        return searchBar
    }()
    
    private let emptyImageView = {
        let emptyImageView = UIImageView()
        emptyImageView.image = UIImage.empty
        emptyImageView.contentMode = .scaleAspectFit
        return emptyImageView
    }()
    
    private let emptyLabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.textColor = Constant.AppColor.black
        emptyLabel.font = Constant.FontSize.titleBold
        emptyLabel.textAlignment = .center
        return emptyLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyImageView.snp.bottom)
        }
    }
    
    // notification center? 사용 방식도 고려해볼것
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationItem()
    }


}
