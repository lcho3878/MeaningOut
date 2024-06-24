//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {

    //MARK: Properties
    private let viewTyle = Constant.ViewType.setting
    
    private let settingMenus = Constant.SettingMenu.allCases

    //MARK: View Properties
    private let settingTableView = UITableView()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
    }
    
    //MARK: View Functions
    override func configureNavigationItem() {
        navigationItem.title = viewTyle.navigationTitle
    }
    
    override func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    override func configureLayout() {
        
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

//MARK: TableView Functions
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.isScrollEnabled = false
        settingTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.id)
        settingTableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.id)
        settingTableView.separatorColor = Constant.AppColor.black
        settingTableView.separatorInset = .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : settingMenus.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.2))
        footerView.backgroundColor = Constant.AppColor.black
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.id, for: indexPath) as? ProfileCell else { return UITableViewCell() }
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.id, for: indexPath) as? SettingCell else { return UITableViewCell() }
            let data = settingMenus[indexPath.row]
            cell.configureData(data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 160 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let profileEditVC = ProfileViewController()
            profileEditVC.viewType = .profileEdit
            profileEditVC.delegate = self
            navigationController?.pushViewController(profileEditVC, animated: true)
        }
        else {
            guard indexPath.row == 4 else { return }
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", confirmTitle: "탈퇴하기", cancelTitle: "확인") {
                User.resetUserDate()
                let onboardVC = OnboardingViewController()
                let rootVC = UINavigationController(rootViewController: onboardVC)
                self.changeRootViewController(rootVC)
            }
        }
    }
    
}

//MARK: ProfileViewControllerDelegate
extension SettingViewController: ProfileViewControllerDelegate {
    
    func updateUI() {
        settingTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }
    
}
