//
//  SearchResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    private let itemImageView = {
        let itemImageView = UIImageView()
        itemImageView.backgroundColor = .black
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        return itemImageView
    }()
    
    private let mallLabel = {
        let mallLabel = UILabel()
        mallLabel.textColor = Constant.AppColor.lightGray
        mallLabel.font = Constant.FontSize.subtTitle
        return mallLabel
    }()
    
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Constant.AppColor.black
        titleLabel.font = Constant.FontSize.content
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let priceLabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = Constant.AppColor.black
        priceLabel.font = Constant.FontSize.titleBold
        return priceLabel
    }()
    
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
        itemImageView.layer.cornerRadius = 16
    }
    
    private func configureHierarchy() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(mallLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    private func configureLayout() {
        
        itemImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        mallLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().offset(4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mallLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(mallLabel)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(titleLabel)
        }
    }
    
    func configureData(_ data: Shopping) {
        mallLabel.text = data.mallName
        titleLabel.text = data.title
        priceLabel.text = data.lprice
    }
    
}
