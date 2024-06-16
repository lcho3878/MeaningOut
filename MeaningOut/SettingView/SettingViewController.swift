//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {

    private let viewTyle = Constant.ViewType.setting
    
    private let settingMenus = Constant.SettingMenu.allCases

    private let settingTableView = {
        let settingTableView = UITableView()
        return settingTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
    }
    
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

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.isScrollEnabled = false
        
        settingTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.id)
        settingTableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : settingMenus.count
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
            
        }
    }
    
}

extension SettingViewController: ProfileViewControllerDelegate {
    
    func updateUI() {
        settingTableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }
    
}
