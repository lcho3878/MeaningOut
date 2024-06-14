//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

protocol ProfileViewControllerDelegate: AnyObject {
    func updateUI()
}

class ProfileViewController: BaseViewController {
    
    var viewType: Constant.ViewType!
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var profileImageView = {
        let profileImageView = UIImageView()
        if viewType == .profileEdit {
            profileImageView.image = User.profileImage
        }
        else {
            profileImageView.image = ProfileImage.profileImages.randomElement()
        }

        profileImageView.layer.borderWidth = Constant.ProfileImageUI.main.borderWidth
        profileImageView.layer.borderColor = Constant.ProfileImageUI.main.borderColor
        profileImageView.layer.masksToBounds = true
        let profileImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        profileImageView.isUserInteractionEnabled = true
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
    
    private lazy var nicknameTextField = {
        let nicknameTextField = UITextField()
        nicknameTextField.font = Constant.FontSize.contentBold
        nicknameTextField.placeholder = Constant.TextFieldType.nickname.rawValue
        if viewType == .profileEdit {
            nicknameTextField.text = User.nickanme
            configureValidCheckLabel(checkValid(User.nickanme))
        }
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEndEdit), for: .editingDidEndOnExit)
        return nicknameTextField
    }()
    
    private let validCheckLabel = {
        let validCheckLabel = UILabel()
        validCheckLabel.font = Constant.FontSize.subtTitle
        validCheckLabel.textColor = Constant.AppColor.orange
        return validCheckLabel
    }()
    
    private lazy var completeButton = {
        let completeButton = OrangeButton(buttonType: .complete)
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        completeButton.isHidden = viewType == .profileEdit
        return completeButton
    }()
    
    private lazy var saveButton = {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClikced))
        saveButton.setTitleTextAttributes([
            .font: Constant.FontSize.titleBold,
            .foregroundColor: Constant.AppColor.black
        ], for: .normal)
        return saveButton
    }()
    
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
        if viewType == .profileEdit {
            navigationItem.rightBarButtonItem = saveButton
        }
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
    
    private func configureValidCheckLabel(_ validResult: Constant.NicknameValid) {
        validCheckLabel.text = validResult.validResult
    }


}

// @objc func, nickname 안되는데 누르면 토스트 메시지 띄워보기, profilesetting관련
extension ProfileViewController {
    @objc
    private func profileImageViewTapped() {
        let profileImageVC = ProfileImageViewController()
        profileImageVC.delegate = self
        profileImageVC.viewType = viewType
        profileImageVC.profileImage = profileImageView.image
        navigationController?.pushViewController(profileImageVC, animated: true)
    }
    
    @objc
    private func completeButtonClicked() {
        guard let nickname = nicknameTextField.text,
              checkValid(nickname) == .correct else { return }
        User.nickanme = nickname
        User.profileImage = profileImageView.image
        User.signupDate = Date().dateString("yyyy.MM.dd")
        let tabbarVC = TabBarController()
        changeRootViewController(tabbarVC)
    }
}

//profileEdit 관련 로직
extension ProfileViewController {
    @objc
    private func saveButtonClikced() {
        guard let nickname = nicknameTextField.text,
              checkValid(nickname) == .correct else { return }
        User.nickanme = nickname
        User.profileImage = profileImageView.image
        delegate?.updateUI()
        navigationController?.popViewController(animated: true)
    }
}

// nicknameTextField 관련 로직
extension ProfileViewController {
    @objc
    private func nicknameTextFieldChanged(_ sender: UITextField) {
        guard let nickname = nicknameTextField.text else { return }
        configureValidCheckLabel(checkValid(nickname))

    }
    
    @objc
    private func nicknameTextFieldEndEdit(_ sender: UITextField) {

    }

    // 유효성 검사 부분 좀더 다듬을 수 있으면 다듬을 것
    private func checkValid(_ text: String?) -> Constant.NicknameValid {
        guard let text = text, text.count >= 2, text.count < 10 else { return .nicknameLength}
        
        let special: [Character] = ["@", "#", "$", "%"]
        let number: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        for char in text {
            if special.contains(char) {
                return .containSpecial
            }
            else if number.contains(char) {
                return .containNumber
            }
        }

        return .correct
    }
}

extension ProfileViewController: ProfileImageViewControllerDelegate {
    
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
    
}
