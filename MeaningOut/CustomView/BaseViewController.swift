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
        guard let content else { return }
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = Constant.AppColor.orange
        view.makeToast(content, duration: 2, position: .bottom, style: toastStyle)
    }
    
    func showAlert(title: String, message: String, confirmTitle: String, cancelTitle: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
        let comfirm = UIAlertAction(title: "확인", style: .destructive)  { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(comfirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
