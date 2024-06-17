//
//  ProfileImageCollectionViewCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properites Overriding
    override var isSelected: Bool {
        didSet {
            let selectType: Constant.ProfileImageUI = isSelected ? .select : .notSelect
            shadowView.layer.opacity = selectType.showdowOpacity
            profileImageView.layer.borderColor = selectType.borderColor
            profileImageView.layer.borderWidth = selectType.borderWidth
        }
    }
    
    //MARK: View Properties
    private let profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = Constant.ProfileImageUI.notSelect.borderColor
        profileImageView.layer.borderWidth = Constant.ProfileImageUI.notSelect.borderWidth
        return profileImageView
    }()
    
    private let shadowView = {
        let shadowView = UIView()
        shadowView.backgroundColor = Constant.AppColor.white
        shadowView.layer.opacity = Constant.ProfileImageUI.notSelect.showdowOpacity
        return shadowView
    }()
    
    //MARK: View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layoutIfNeeded()
        profileImageView.makeCircle()
    }
    
    //MARK: View Functions
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

    func configureData(_ data: UIImage?) {
        profileImageView.image = data
    }
    
}
