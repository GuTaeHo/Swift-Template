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
    private let homeViewModel = HomeViewModel()
    private let input = PassthroughSubject<Int, Never>.init()
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
        
        bind()
    }
    
    private func bind() {
        let output = homeViewModel.transform(
            input: HomeViewModel.Input(input)
        )
        
        output.receive(on: DispatchQueue.main)
            .sink { [weak self] worryDetail in
                
            }
            .sink(receiveValue: { [weak self] worryDetail in
                 // 받은 값을 통한 UI 업데이트
                self?.updateUI(worryDetail: worryDetail)
            })
            .store(in: &cancellables)
    }
}

