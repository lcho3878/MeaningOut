//
//  WishListViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 7/7/24.
//

import UIKit
import SnapKit
import RealmSwift

final class WishListViewController: BaseViewController {
    
    var list = WishRepository.shared.readItems()
    
    private let wishCollectionViewLayout = {
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
    
    private lazy var wishCollectionView = UICollectionView(frame: .zero, collectionViewLayout: wishCollectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        let realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wishCollectionView.reloadData()
    }
    
    override func configureNavigationItem() {
        title = "장바구니"
    }
    
    override func configureHierarchy() {
        view.addSubview(wishCollectionView)
    }
    
    override func configureLayout() {
        wishCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        wishCollectionView.delegate = self
        wishCollectionView.dataSource = self
        wishCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        let data = list[indexPath.row]
        cell.tag = indexPath.row
        cell.configureData(data)
        return cell
    }
    
}
