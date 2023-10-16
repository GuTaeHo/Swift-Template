//
//  MainViewController.swift
//  MyCoordinator
//
//  Created by 구태호 on 10/16/23.
//

import UIKit

protocol MainViewControllerDelegate {
    func logout()
}

class MainViewController: UIViewController {

    var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logoutButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }
    
    deinit {
        print("deinit - \(Self.self)")
    }
    
    @objc
    func logoutButtonDidTap() {
        self.delegate?.logout()
    }
}
