//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import WebKit
import SnapKit

protocol DetailViewControllerDelegate: AnyObject {
    func updateUI(_ row: Int)
}

final class DetailViewController: BaseViewController {

    //MARK: Properties
    private let viewType = Constant.ViewType.result
    
    var data: Shopping!
    
    var row: Int?
    
    weak var delegate: DetailViewControllerDelegate?
    
    //MARK: View Properties
    private let webView = WKWebView()
    
    private let activityIndicator = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = Constant.AppColor.orange
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var rightBarButton = {
        let rightBarButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(barButtonClick))
        return rightBarButton
    }()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonImage()
        configureWebView()
        webViewLoad()
    }
    
    //MARK: View Functions
    override func configureNavigationItem() {
        navigationItem.title = data.cleanTitle
        navigationItem.rightBarButtonItem = rightBarButton
    }

    override func configureHierarchy() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }
    
    override func configureLayout() {
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

}

//MARK: BarButton Functions
extension DetailViewController {
    
    private func configureBarButtonImage() {
        rightBarButton.image = (data.isLike ? UIImage.likeSelected : UIImage.likeUnselected).withRenderingMode(.alwaysOriginal)
    }
    
    @objc
    private func barButtonClick() {
        guard let row else { return }
        User.updateWishList(data.productId)
        WishRepository.shared.updateWishList(data)
        configureBarButtonImage()
        delegate?.updateUI(row)
    }
    
}

//MARK: WebView Functions
extension DetailViewController: WKNavigationDelegate {
    
    private func configureWebView() {
        webView.navigationDelegate = self
    }
    
    private func webViewLoad() {
        let url = URL(string: data.link)!
        let request = URLRequest(url: url, timeoutInterval: 5)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        showToast(error.localizedDescription)
        activityIndicator.stopAnimating()
    }
}
