//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit
import WebKit

class DetailViewController: BaseViewController {

    private let viewType = Constant.ViewType.result
    
    var data: Shopping!
    
    private let webView = WKWebView()
    
    private let rightBarButton = {
        let rightBarButton = UIBarButtonItem()
        rightBarButton.image = UIImage(systemName: "cart.fill.badge.plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return rightBarButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: data.link)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func configureNavigationItem() {
        navigationItem.title = data.title
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

}
