//
//  BlueViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/12/01.
//

import UIKit

class BlueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        initLayout()
        print(navigationItem.titleView)
    }
    
    func initLayout() {
        // 네비게이션 바 아이템 UI 설정 및 액션 등록
        let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(moveHome))
        barButtonItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        barButtonItem.image = .init(systemName: "house")
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func moveHome() {
        navigationController?.popToRootViewController(animated: true)
    }
}


extension BlueViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { false }
}
