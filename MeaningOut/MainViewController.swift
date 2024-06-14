//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class MainViewController: BaseViewController {
    
    private let viewType = Constant.ViewType.main

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = viewType.navigationTitle
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }


}