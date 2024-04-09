//
//  HomeViewController.swift
//  MyGoogleSignIn
//
//  Created by 구태호 on 4/3/24.
//

import UIKit
import SnapKit
import Then
import Combine

class HomeViewController: UIViewController {
    let viewModel: HomeViewModel
    private let input = PassthroughSubject<HomeViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let googleLoginButton = UIButton(configuration: .filled()).then {
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .systemPink
        var container = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ])
        $0.configuration?.attributedTitle = .init("구글 로그인", attributes: container)
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    
        googleLoginButton.addAction(UIAction { [weak self] _ in
            self?.input.send(.googleSignIn)
        }, for: .touchUpInside)
        
        bind()
    }
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output.receive(on: DispatchQueue.main)
            .sink { event in
                switch event {
                case .googleSignIn(let response):
                    if let errorReason = response.errorReason {
                        print(errorReason)
                        return
                    }
                    
                    guard
                        let email = response.user?.email,
                        let token = response.user?.uid
                    else {
                        print("이메일 또는 토큰 없음")
                        return
                    }
                    
                    print("email: \(email), token: \(token)")
                }
            }
            .store(in: &cancellables)
    }
}

