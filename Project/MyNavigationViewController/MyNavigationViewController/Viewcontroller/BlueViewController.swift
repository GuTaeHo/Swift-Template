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
        
        navigationController?.setTitleColor(.white)
        navigationController?.disablePopGesture()
        initLayout()
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.enablePopGesture()
        navigationController?.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
    }
}
