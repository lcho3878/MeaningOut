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
        
        setViewControllers([mainNaVC], animated: false)
    }
    
}
