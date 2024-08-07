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

final class ProfileViewController: BaseViewController {
    
    //MARK: Properties
    var viewType: Constant.ViewType!
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private let viewModel = ProfileViewModel()
    
    //MARK: View Properties
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
    
    private let cameraImageView = {
        let cameraImageView = UIImageView()
        cameraImageView.image = Constant.IconImage.cameraFill?.withTintColor(Constant.AppColor.white, renderingMode: .alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = Constant.AppColor.orange
        return cameraImageView
    }()
    
    private lazy var nicknameTextField = {
        let nicknameTextField = UITextField()
        nicknameTextField.font = Constant.FontSize.contentBold
        nicknameTextField.placeholder = Constant.TextFieldType.nickname.rawValue
        if viewType == .profileEdit {
            nicknameTextField.text = User.nickname
        }
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
        return nicknameTextField
    }()
    
    private let validCheckLabel = {
        let validCheckLabel = UILabel()
        validCheckLabel.font = Constant.FontSize.subtTitle
        validCheckLabel.textColor = Constant.AppColor.orange
        return validCheckLabel
    }()
    
    private lazy var completeButton = {
        let completeButton = UIButton(configuration: .orangeButton(buttonType: .complete), primaryAction: UIAction(handler: { _ in
            self.completeButtonClicked()
        }))
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
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.makeCircle()
        cameraImageView.makeCircle()
        nicknameTextField.makeUnderLine(width: 0.5, color: .black)
    }
    
    //MARK: View Functions
    private func bindData() {
        viewModel.outputNickname.bind { value in
            self.validCheckLabel.text = value
        }
        nicknameTextFieldChanged(nicknameTextField)
        viewModel.outputError.bind { error in
            self.showToast(error?.validResult)
        }
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
    


}

//MARK: ImageTapGesture, Button Functions
extension ProfileViewController {
    @objc
    private func profileImageViewTapped() {
        let profileImageVC = ProfileImageViewController()
        profileImageVC.delegate = self
        profileImageVC.viewType = viewType
        profileImageVC.profileImage = profileImageView.image
        navigationController?.pushViewController(profileImageVC, animated: true)
    }
    
    private func completeButtonClicked() {
        viewModel.saveButtonClikced.value = ()
        guard viewModel.outputError.value == nil else { return }
        User.profileImage = profileImageView.image
        User.signupDate = Date().dateString("yyyy.MM.dd")
        let tabbarVC = TabBarController()
        changeRootViewController(tabbarVC)
    }
    
    @objc
    private func saveButtonClikced() {
        viewModel.saveButtonClikced.value = ()
        guard viewModel.outputError.value == nil else { return }
        User.profileImage = profileImageView.image
        delegate?.updateUI()
        navigationController?.popViewController(animated: true)
    }
    

}

//MARK: TextField Functions
extension ProfileViewController {

    @objc
    private func nicknameTextFieldChanged(_ sender: UITextField) {
        viewModel.inputNickname.value = nicknameTextField.text
    }
    
}

//MARK: ProfileImageViewControllerDelegate
extension ProfileViewController: ProfileImageViewControllerDelegate {
    
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
    
}
