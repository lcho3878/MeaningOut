//
//  BaseViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController, CodeBasable {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        configureNavigationItem()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
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
    
    func showToast(_ content: String?) {
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = Constant.AppColor.orange
        view.makeToast(content, duration: 2, position: .bottom, style: toastStyle)
    }
    
}
