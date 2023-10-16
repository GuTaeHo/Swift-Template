//
//  LoginViewController.swift
//  MyCoordinator
//
//  Created by 구태호 on 10/16/23.
//

import UIKit

protocol LoginViewControllerDelegate {
    func login()
}

class LoginViewController: UIViewController {
    var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UIBarButtonItem(title: "로그인", style: .plain, target: self, action: #selector(self.loginButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }
    
    deinit {
        print("deinit - \(Self.self)")
    }
    
    @objc
    func loginButtonDidTap() {
        self.delegate?.login()
    }
}

