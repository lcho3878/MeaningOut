//
//  ViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController  {

    //MARK: View Properties
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.text = "MeaningOut"
        titleLabel.textColor = Constant.AppColor.orange
        titleLabel.font = .systemFont(ofSize: 50, weight: .black)
        return titleLabel
    }()
    
    private let mainImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.launch
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var startButton = {
        let startButton = UIButton(configuration: .orangeButton(buttonType: .start), primaryAction: UIAction(handler: { _ in
            self.startButtonClicked()
        }))
        return startButton
    }()

    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: View Functions
    override func configureHierarchy() {
        view.addSubview(mainImageView)
        view.addSubview(titleLabel)
        view.addSubview(startButton)
    }
    
    override func configureLayout() {
        
        mainImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(mainImageView.snp.top)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
    }

}

//MARK: startButton Functions
extension OnboardingViewController {
    private func startButtonClicked() {
        let profileSettingVC = ProfileViewController()
        profileSettingVC.viewType = Constant.ViewType.profileSetting
        navigationController?.pushViewController(profileSettingVC, animated: true)
    }
}

