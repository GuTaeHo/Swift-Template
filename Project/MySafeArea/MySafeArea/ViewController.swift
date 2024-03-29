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
    
    
    private lazy var stackViewPaddingTest: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: .zero, right: 10)
        // MARK: 스택뷰에 layoutMargins 를 적용하기 위해선 아래 값을 true 로 변경해줘야함
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .orange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var viewForStackView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        
        stackViewPaddingTest.addArrangedSubview(viewForStackView)
        viewForStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackViewPaddingTest.addArrangedSubview(viewForStackView)
        viewForStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackViewPaddingTest.addArrangedSubview(viewForStackView)
        viewForStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(stackViewPaddingTest)
        
        NSLayoutConstraint.activate([
            stackViewPaddingTest.widthAnchor.constraint(equalToConstant: 300),
            stackViewPaddingTest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewPaddingTest.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func login() {
        view.endEditing(true)
    }
}

