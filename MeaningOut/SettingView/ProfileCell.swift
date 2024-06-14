//
//  ProfileCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileCell: UITableViewCell {

    private let profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.layer.borderColor = Constant.ProfileImageUI.main.borderColor
        profileImageView.layer.borderWidth = Constant.ProfileImageUI.main.borderWidth
        profileImageView.clipsToBounds = true
        return profileImageView
    }()
    
    private let nicknameLabel = {
        let nicknameLabel = UILabel()
        nicknameLabel.textColor = Constant.AppColor.black
        nicknameLabel.font = Constant.FontSize.titleBold
        return nicknameLabel
    }()
    
    private let dateLabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Constant.AppColor.lightGray
        dateLabel.font = Constant.FontSize.subtTitle
        return dateLabel
    }()
    
    private let disclosureImageView = {
        let disclosureImageView = UIImageView()
        disclosureImageView.image = UIImage(systemName: "chevron.right")
        return disclosureImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureData()
    }
    
    override func layoutSubviews() {
        profileImageView.layoutIfNeeded()
        profileImageView.makeCircle()
    }
    
    private func configureHierachy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(disclosureImageView)
    }
    
    private func configureLayout() {
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(12)
        }
        
        disclosureImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureData() {
        profileImageView.image = User.profileImage
        nicknameLabel.text = User.nickanme
        dateLabel.text = User.signupDate
    }


}
