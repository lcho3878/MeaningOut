//
//  SearchCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    private let clockImageView = {
        let clockImageView = UIImageView()
        clockImageView.image = Constant.IconImage.clock
        return clockImageView
    }()
    
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.font = Constant.FontSize.content
        return titleLabel
    }()
    
    private let deleteButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(Constant.IconImage.xmark, for: .normal)
        return deleteButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(clockImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
    }
    
    private func configureLayout() {
        
        clockImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(clockImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(clockImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(clockImageView)
        }
    }
    
    func configureData(_ data: String) {
        titleLabel.text = data
    }
    
}
