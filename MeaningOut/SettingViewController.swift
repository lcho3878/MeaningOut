//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class SettingViewController: BaseViewController {

    private let viewTyle = Constant.ViewType.setting
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewTyle.navigationTitle
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }


}
