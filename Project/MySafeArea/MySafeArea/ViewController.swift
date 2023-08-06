//
//  ViewController.swift
//  MySafeArea
//
//  Created by 구태호 on 2022/09/22.
//

import UIKit

// MARK: iOS 15 부터 새로추가된 UIKeyboardLayoutGuide 를 사용하면 이전의 복잡한 키보드 UI 처리방법 대신, 자동으로 처리를 해준다.
class ViewController: UIViewController {
    @IBOutlet var lbSafeAreas: [UILabel]!
    
    private lazy var idTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = " ID"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = " Password"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        
        NSLayoutConstraint.activate([
            idTextField.widthAnchor.constraint(equalToConstant: 300),
            idTextField.heightAnchor.constraint(equalToConstant: 30),
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            
            /*
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
             */
            
            // 하단 제약조건 UIKeyboardLayoutGuide의 상단과 맞춤
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -50)
        ])
    }
    
    @objc func login() {
        view.endEditing(true)
    }
}

