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
    private lazy var homeViewModel = HomeViewModel(presentVC: self)
    private let input = HomeViewModel.Input(
        googleSignin: PassthroughSubject<Int, Never>.init().eraseToAnyPublisher()
    )
    private var cancellables = Set<AnyCancellable>()
    
    let googleLoginButton = UIButton(configuration: .filled()).then {
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .systemPink
        var container = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ])
        $0.configuration?.attributedTitle = .init("구글 로그인", attributes: container)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    
        googleLoginButton.addAction(UIAction { [weak self] _ in
            self?.homeViewModel.googleSignIn()
        }, for: .touchUpInside)
        
        bind()
    }
    
    private func bind() {
        let output = homeViewModel.transform(input: input)
        
        output.receive(on: DispatchQueue.main)
            .sink { response in
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
            .store(in: &cancellables)
    }
}

