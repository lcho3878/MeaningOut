//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

import SnapKit
import Toast

class SearchResultViewController: BaseViewController {
    
    //MARK: Properties
    var query: String!
    
    private var start = 1
    
    private var display = 30
    
    private var total = 0
    
    private var list: [Shopping] = []{
        didSet {
            resultCollectionView.reloadData()
        }
    }
    
    private var sort = Constant.FilterButtonType.sim.sort {
        didSet{
            guard oldValue != sort else { return }
            callRequest()
        }
    }
    
    private let viewType = Constant.ViewType.result
    
    //MARK: View Properties
    private let totalLabel = {
        let totalLabel = UILabel()
        totalLabel.textColor = Constant.AppColor.orange
        totalLabel.font = Constant.FontSize.contentBold
        return totalLabel
    }()
    
    private let simButton = FilterButton(buttonType: .sim)
    
    private let dateButton = FilterButton(buttonType: .date)
    
    private let dscButton = FilterButton(buttonType: .dsc)
    
    private let ascButton = FilterButton(buttonType: .asc)
    
    private lazy var buttonList = [simButton, dateButton, dscButton, ascButton]

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

    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureButton()
        configureSelectedButton()
    }

    override func configureNavigationItem() {
        navigationItem.title = query
    }
    
    override func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(simButton)
        view.addSubview(dateButton)
        view.addSubview(dscButton)
        view.addSubview(ascButton)
        view.addSubview(resultCollectionView)
    }
    
    //MARK: View Functions
    override func configureLayout() {
        
        totalLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        simButton.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(8)
            $0.leading.equalTo(totalLabel)
            $0.height.equalTo(30)
        }
        
        dateButton.snp.makeConstraints {
            $0.top.equalTo(simButton)
            $0.height.equalTo(simButton)
            $0.leading.equalTo(simButton.snp.trailing).offset(8)
        }
        
        dscButton.snp.makeConstraints {
            $0.top.equalTo(simButton)
            $0.height.equalTo(simButton)
            $0.leading.equalTo(dateButton.snp.trailing).offset(8)
        }
        
        ascButton.snp.makeConstraints {
            $0.top.equalTo(simButton)
            $0.height.equalTo(simButton)
            $0.leading.equalTo(dscButton.snp.trailing).offset(8)
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(simButton.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

//MARK: API Request Function
extension SearchResultViewController {
    
    private func callRequest() {
        NaverAPIManager.shared.callRequest(query: query, sort: sort, display: display, start: start) { value, error in
            guard error == nil else {
                self.showToast(error?.rawValue)
                return
            }
            guard let value else { return }
            if self.start == 1 {
                self.total = value.total
                self.totalLabel.text = value.totlaResult
                self.list = value.items
                guard !self.list.isEmpty else { return }
                self.resultCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top , animated: true)
            }
            else {
                self.list.append(contentsOf: value.items)
            }
        }
    }
    
}

//MARK: CollectionView Functions
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        resultCollectionView.prefetchDataSource = self
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
        cell.configureData(data, query)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.data = data
        detailVC.row = indexPath.row
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: Pagination Functions
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == list.count - 10 , start + display <= total {
                start += display
                callRequest()
            }
        }
    }
    
}

//MARK: Button Functions
extension SearchResultViewController {
    
    private func configureButton() {
        buttonList.enumerated().forEach {
            $0.element.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            $0.element.tag = $0.offset
        }
    }
    
    private func configureSelectedButton() {
        simButton.isSelected = true
        sort = "sim"
        callRequest()
    }
    
    @objc
    private func clickButton(_ sender: FilterButton) {
        buttonList.forEach { $0.isSelected = false }
        sender.isSelected = true
        start = 1
        sort = Constant.FilterButtonType.allCases[sender.tag].sort

    }
    
}

//MARK: DetailViewControllerDelegate
extension SearchResultViewController: DetailViewControllerDelegate {
    
    func updateUI(_ row: Int) {
        resultCollectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
    }
    
}

//MARK: SearchResultCollectionViewCellDelegate
extension SearchResultViewController: SearchResultCollectionViewCellDelegate {
    
    func reloadData(_ row: Int) {
        resultCollectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
    }
    
}
