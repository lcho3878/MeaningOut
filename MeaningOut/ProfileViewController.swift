//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    var viewType: Constant.ViewType!
    
    private let profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage.profile0
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = Constant.AppColor.orange.cgColor
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()
    
    //카메라 이미지 크기 조정 좀 더 고려해볼 것
    private let cameraImageView = {
        let cameraImageView = UIImageView()
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withTintColor(Constant.AppColor.white, renderingMode: .alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = Constant.AppColor.orange
        return cameraImageView
    }()
    
    private let nicknameTextField = {
        let nicknameTextField = UITextField()
        nicknameTextField.font = Constant.FontSize.contentBold
        nicknameTextField.placeholder = Constant.TextFieldType.nickname.rawValue
        return nicknameTextField
    }()
    
    private let validCheckLabel = {
        let lb = UILabel()
        lb.font = Constant.FontSize.subtTitle
        lb.textColor = Constant.AppColor.orange
        return lb
    }()
    
    private let completeButton = OrangeButton(buttonType: .complete)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.makeCircle()
        cameraImageView.makeCircle()
        nicknameTextField.makeUnderLine(width: 0.5, color: .black)
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(validCheckLabel)
        view.addSubview(completeButton)
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
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(50)
        }
        
        validCheckLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(nicknameTextField)
            $0.height.equalTo(20)
        }
        
        completeButton.snp.makeConstraints{
            $0.top.equalTo(validCheckLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(validCheckLabel)
            $0.height.equalTo(50)
        }
    }
    
}
