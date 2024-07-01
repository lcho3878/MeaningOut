//
//  SettingCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

final class SettingCell: UITableViewCell {
    
    //MARK: View Properties
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Constant.AppColor.black
        titleLabel.font = Constant.FontSize.content
        return titleLabel
    }()
    
    private let cartImageView = {
        let cartImageView = UIImageView()
        cartImageView.image = UIImage.likeSelected
        cartImageView.isHidden = true
        return cartImageView
    }()
    
    private let wishListLabel = {
        let wishListLabel = UILabel()
        wishListLabel.isHidden = true
        return wishListLabel
    }()

    //MARK: View Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Functions
    private func configureHierachy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(wishListLabel)
        contentView.addSubview(cartImageView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        wishListLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        cartImageView.snp.makeConstraints {
            $0.trailing.equalTo(wishListLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(wishListLabel)
            $0.width.equalTo(cartImageView.snp.height)
        }
    }
    
    func configureData(_ data: Constant.SettingMenu) {
        titleLabel.text = data.rawValue
        guard data == .wishList else { return }
        wishListLabel.attributedText = User.wishListCountLabelText
        wishListLabel.isHidden = false
        cartImageView.isHidden = false
    }
    
}
