//
//  SearchCell.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import SnapKit

protocol SearchCellDelegate: AnyObject {
    func removeElement(_ key: String)
}

class SearchCell: UITableViewCell {
    
    //MARK: Properties
    var key: String!
    
    weak var delegate: SearchCellDelegate?
    
    //MARK: View Properties
    private let clockImageView = {
        let clockImageView = UIImageView()
        clockImageView.image = Constant.IconImage.clock?.withTintColor(Constant.AppColor.black, renderingMode: .alwaysOriginal)
        return clockImageView
    }()
    
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.font = Constant.FontSize.content
        return titleLabel
    }()
    
    private lazy var deleteButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(Constant.IconImage.xmark?.withTintColor(Constant.AppColor.black, renderingMode: .alwaysOriginal), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        return deleteButton
    }()
    
    private let dateLabel = {
        let dateLabel = UILabel()
        dateLabel.font = Constant.FontSize.subtTitle
        dateLabel.textColor = Constant.AppColor.middleGray
        return dateLabel
    }()

    //MARK: View Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Functions
    private func configureHierarchy() {
        contentView.addSubview(clockImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(dateLabel)
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
            $0.trailing.equalTo(dateLabel.snp.leading).inset(-8)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(clockImageView)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
    }
    
    func configureData(_ data: Dictionary<String, Date>.Element) {
        titleLabel.text = data.key
        dateLabel.text = data.value.dateString("MM. dd a hh:mm")
    }
    
}

//MARK: Button Functions
extension SearchCell {
    @objc
    private func deleteButtonClicked() {
        delegate?.removeElement(key)
    }
}
