//
//  TestViewController.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 10/28/23.
//

import UIKit
import Combine

// UIKit + MVVM + Combine + CodeBaseUI 을 결합한 예제
// 참고: https://velog.io/@aurora_97/Combine-UIKit-MVVM-Combine-%EC%98%88%EC%A0%9C

class TestViewController: UIViewController {
    private let userSubject = PassthroughSubject<String, Never>()
    private let passwordSubject = PassthroughSubject<String, Never>()
    private let passwordAgainSubject = PassthroughSubject<String, Never>()

    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = TestViewModel()
    
    lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "버튼 퍼블리셔 테스트"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var wrapperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, passwordTextField, passwordAgainTextField])
        stackView.axis = .vertical
        stackView.layoutMargins = .init(top: 18, left: 12, bottom: 18, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.placeholder = "이름을 입력해주세요"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.placeholder = "다시 한번 더 비밀번호를 입력해주세요"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "회원가입"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        button.touchUpInsidePublisher.sink { [weak self] sender in
            print(sender.currentTitle)
        }.store(in: &cancelBag)
        

        view.addSubview(wrapperStackView)
        view.addSubview(registButton)
        
        // MARK: target-action 방식
        /*
        nameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        passwordAgainTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
         */
        
        NSLayoutConstraint.activate([
            wrapperStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wrapperStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wrapperStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            registButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            registButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -12),
            registButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            registButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        bindView()
        
        // MARK: target-action 방식
        /*
        userSubject.sink { text in
            print(text)
        }.store(in: &cancelBag)
        
        passwordSubject.sink { text in
            print(text)
        }.store(in: &cancelBag)
        
        passwordAgainSubject.sink { text in
            print(text)
        }.store(in: &cancelBag)
         */
        
        
    }
    
    // MARK: target-action 방식 -> closure handler 방식으로 변경
    /// UIView를 `Publisher` 와 바인딩 합니다.
    func bindView() {
        let input = TestViewModel.Input(
            userName: userSubject.eraseToAnyPublisher(),
            password: passwordSubject.eraseToAnyPublisher(),
            passwordAgaing: passwordAgainSubject.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)
        output
            .buttonIsValid
            .sink { [weak self] state in
                self?.registButton.isEnabled = state
                self?.registButton.configuration?.baseForegroundColor = state ? .lightGray : .systemIndigo
            }.store(in: &cancelBag)
        
        nameTextField.editingChangedPublisher.sink { [weak self] text in
            print(text)
        }.store(in: &cancelBag)
        
        passwordTextField.editingChangedPublisher.sink { text in
            print(text)
        }.store(in: &cancelBag)
        
        passwordAgainTextField.editingChangedPublisher.sink { text in
            print(text)
        }.store(in: &cancelBag)
    }
    
    // MARK: target-action 방식
    /*
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case nameTextField:
            userSubject.send(sender.text!)
        case passwordTextField:
            passwordSubject.send(sender.text!)
        case passwordAgainTextField:
            passwordAgainSubject.send(sender.text!)
        default:
            break
        }
    }
     */
}
