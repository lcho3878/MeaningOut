//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    //MARK: Properties
    var list = User.searchList{
        didSet{
            User.searchList = list
            configureIsHidden()
            searchTableView.reloadData()
        }
    }
    
    private let viewType = Constant.ViewType.main
    
    //MARK: View Properties
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
    
    private let mainView = UIView()
    
    private let headerView = UIView()
    
    private let allLabel = {
        let allLabel = UILabel()
        allLabel.text = "최근 검색"
        allLabel.font = Constant.FontSize.titleBold
        return allLabel
    }()
    
    private lazy var deleteButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("전체 삭제", for: .normal)
        deleteButton.setTitleColor(Constant.AppColor.orange, for: .normal)
        deleteButton.titleLabel?.font = Constant.FontSize.subtTitle
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        return deleteButton
    }()
    
    private let searchTableView = UITableView()

    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureTableView()
        configureIsHidden()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationItem()
    }
    
    //MARK: View Functions
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        view.addSubview(mainView)
        mainView.addSubview(headerView)
        mainView.addSubview(searchTableView)
        headerView.addSubview(allLabel)
        headerView.addSubview(deleteButton)
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
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        allLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    private func configureIsHidden() {
        mainView.isHidden = list.isEmpty
    }
    
    private func pushViewController(_ query: String) {
        let searchResultVC = SearchResultViewController()
        list[query] = Date()
        searchResultVC.query = query
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

//MARK: Button Functions
extension MainViewController {
    
    @objc
    private func deleteButtonClicked() {
        list.removeAll()
    }
    
}

//MARK: SearchBar Functions
extension MainViewController: UISearchBarDelegate {
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.searchTextField.text else { return }
        searchBar.resignFirstResponder()
        pushViewController(query)
    }
}

//MARK: TableView Functions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.id)
        searchTableView.separatorStyle = .none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let data = list.sorted { $0.value > $1.value }[indexPath.row]
        cell.key = data.key
        cell.configureData(data)

        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = list.sorted { $0.value > $1.value }[indexPath.row].key
        pushViewController(query)
    }
    
}

//MARK: SearchCellDelegate
extension MainViewController: SearchCellDelegate {
    
    func removeElement(_ key: String) {
        list.removeValue(forKey: key)
    }

}


