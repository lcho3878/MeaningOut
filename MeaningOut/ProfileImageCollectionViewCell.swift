//
//  ProfileImageCollectionViewCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView = {
        let view = UIImageView()
        view.image = UIImage.profile1
        view.clipsToBounds = true
        view.layer.borderColor = Constant.ProfileImage.notSelect.borderColor
        view.layer.borderWidth = Constant.ProfileImage.notSelect.borderWidth
        return view
    }()
    
    private let shadowView = {
        let view = UIView()
        view.backgroundColor = Constant.AppColor.white
        view.layer.opacity = Constant.ProfileImage.notSelect.showdowOpacity
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layoutIfNeeded()
        profileImageView.makeCircle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            let selectType: Constant.ProfileImage = isSelected ? .select : .notSelect
            shadowView.layer.opacity = selectType.showdowOpacity
            profileImageView.layer.borderColor = selectType.borderColor
            profileImageView.layer.borderWidth = selectType.borderWidth
        }
    }
    
    private func configureHierarchy() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(profileImageView)
    }
    
    private func configureLayout() {
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    
}
