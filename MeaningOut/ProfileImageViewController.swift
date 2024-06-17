//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

protocol ProfileImageViewControllerDelegate: AnyObject {
    func updateProfileImage(_ image: UIImage)
}

class ProfileImageViewController: BaseViewController {
    
    //MARK: Properties
    var viewType: Constant.ViewType!
    
    var profileImage: UIImage!
    
    private let profileImages = ProfileImage.profileImages
    
    weak var delegate: ProfileImageViewControllerDelegate?
    
    //MARK: View Properties
    private lazy var profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = profileImage
        profileImageView.layer.borderWidth = Constant.ProfileImageUI.main.borderWidth
        profileImageView.layer.borderColor = Constant.AppColor.orange.cgColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()

    private let cameraImageView = {
        let cameraImageView = UIImageView()
        cameraImageView.image = Constant.IconImage.cameraFill?.withTintColor(Constant.AppColor.white, renderingMode: .alwaysOriginal)
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
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.makeCircle()
        cameraImageView.makeCircle()
    }
    
    //MARK: View Functions
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

//MARK: CollectionView Functions
extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        guard let selectedIndex = profileImages.firstIndex(of: profileImage) else { return }
        imageCollectionView.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        let data = profileImages[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = profileImages[indexPath.row]
        profileImageView.image = image
        delegate?.updateProfileImage(image)
    }

}
