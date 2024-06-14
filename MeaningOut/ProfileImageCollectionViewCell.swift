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
        view.layer.borderColor = Constant.AppColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let shadowView = {
        let view = UIView()
        view.backgroundColor = Constant.AppColor.white
        view.layer.opacity = 0.5
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
            if isSelected {
                shadowView.layer.opacity = 1
                profileImageView.layer.borderColor = Constant.AppColor.orange.cgColor
                profileImageView.layer.borderWidth = 3
            }
            else {
                shadowView.layer.opacity = 0.5
                profileImageView.layer.borderColor = Constant.AppColor.lightGrayBorder.cgColor
                profileImageView.layer.borderWidth = 1
            }
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
