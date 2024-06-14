//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class ProfileImageViewController: BaseViewController {
    
    var viewType: Constant.ViewType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("프로일 이미지 선택뷰")
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
}
