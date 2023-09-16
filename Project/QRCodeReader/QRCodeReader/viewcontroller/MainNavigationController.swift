//
//  MainNavigationController.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/10.
//

import UIKit


class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        initLayout()
        initNavigationBarLayout()
    }
    
    private func initLayout() {
        // 네비게이션 배경색 지정
        view.backgroundColor = .white
    }
    
    private func initNavigationBarLayout() {
        // 타이틀 지정
        navigationItem.title = "QR 코드 리더기"
        navigationItem.titleView?.tintColor = .black
    }
}
