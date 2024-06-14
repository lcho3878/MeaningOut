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
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
        
        configureHierarchy()
        configureLayout()
        configureNavigationItem()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func configureNavigationItem() {}
    
    func configureHierarchy() {}
    
    func configureLayout() {}
    
    func changeRootViewController(_ rootViewController: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
