//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    var viewType: Constant.ViewType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
}
