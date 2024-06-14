//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainVC = MainViewController()
        let mainNaVC = UINavigationController(rootViewController: mainVC)
        mainNaVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let settingVC = SettingViewController()
        let settingNaVC = UINavigationController(rootViewController: settingVC)
        settingNaVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        tabBar.tintColor = Constant.AppColor.orange
        tabBar.unselectedItemTintColor = Constant.AppColor.lightGray
        setViewControllers([mainNaVC, settingNaVC], animated: false)
    }
    
}
