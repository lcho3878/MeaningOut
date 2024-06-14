//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageViewController: BaseViewController {
    
    var viewType: Constant.ViewType!
    
    private let profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage.profile0
        profileImageView.layer.borderWidth = Constant.ProfileImageUI.main.borderWidth
        profileImageView.layer.borderColor = Constant.AppColor.orange.cgColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()

    private let cameraImageView = {
        let cameraImageView = UIImageView()
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withTintColor(Constant.AppColor.white, renderingMode: .alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = Constant.AppColor.orange
        return cameraImageView
    }()
    
    private let imageCollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 12
        let width = (UIScreen.main.bounds.width - 5 * spacing)
 
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        
        let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return imageCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.makeCircle()
        cameraImageView.makeCircle()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraImageView)
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(view.safeAreaLayoutGuide.snp.width).dividedBy(3)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.size.equalTo(profileImageView).dividedBy(4)
            $0.bottom.trailing.equalTo(profileImageView).inset(4)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(48)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileImageCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImage.profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileImageCollectionViewCell", for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        let data = ProfileImage.profileImages[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
    
}
