//
//  ViewController.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 10/27/23.
//

import UIKit
import Combine


class ViewController: UIViewController {
    /// 버튼 클릭 퍼블리셔
    private var buttonPressedSubject = PassthroughSubject<String, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    lazy var testViewControllerButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = "테스트 뷰 컨트롤러"
        button.configurationUpdateHandler = { [weak self] button in
            if button.state == .normal {
                /// `PassthroughSubject` 의 send() 함수는 구독자에게 이벤트를 전달한다
                self?.buttonPressedSubject.send("테스트 뷰 컨트롤러 이동 버튼 클릭됨")
            }
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(testViewControllerButton)
        NSLayoutConstraint.activate([
            testViewControllerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            testViewControllerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        ])
        
        buttonPressedSubject.sink { [weak self] result in
            print(result)
            let vc = TestViewController()
            self?.present(vc, animated: true)
        }.store(in: &cancelBag)
    }
}

