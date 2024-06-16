//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import WebKit

protocol DetailViewControllerDelegate: AnyObject {
    func updateUI(_ row: Int)
}

class DetailViewController: BaseViewController {

    private let viewType = Constant.ViewType.result
    
    var data: Shopping!
    
    var row: Int?
    
    weak var delegate: DetailViewControllerDelegate?
    
    private let webView = WKWebView()
    
    private lazy var rightBarButton = {
        let rightBarButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(barButtonClick))
        return rightBarButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonImage()
        webViewLoad()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = data.cleanTitle
        navigationItem.rightBarButtonItem = rightBarButton
    }

    override func configureHierarchy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func webViewLoad() {
        let url = URL(string: data.link)!
        let request = URLRequest(url: url)
        webView.load(request)
    }

}

//바버튼 관련 로직
extension DetailViewController {
    
    private func configureBarButtonImage() {
        rightBarButton.image = (data.isLike ? UIImage.likeSelected : UIImage.likeUnselected).withRenderingMode(.alwaysOriginal)
    }
    
    @objc
    private func barButtonClick() {
        guard let row else { return }
        User.updateWishList(data.productId)
        configureBarButtonImage()
        delegate?.updateUI(row)
    }
    
}
