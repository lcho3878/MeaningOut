//
//  BaseViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class BaseViewController: UIViewController, CodeBasable {

    /*
     configure함수들을 viewDidLoad에서 실행하므로 상속받은 클래스에서는
     configure함수를 구현하여 사용하면 자동으로 실행함
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
}
