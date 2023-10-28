//
//  TestViewModel.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 10/28/23.
//

import Foundation
import Combine


final class TestViewModel: ViewModeling {
    /// 사용자 입력(UITextField.text)을 방출하는 퍼블리셔
    struct Input {
        let userName: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let passwordAgaing: AnyPublisher<String, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    /// `Input` 을 `CombineLatest` 로 결합한 뒤, 유효성 검사 후 통과 시 `Output` 으로 값 방출
    func transform(input: Input) -> Output {
        let buttonStatePublisher = input.userName.combineLatest(input.password, input.passwordAgaing)
            .map { user, password, passwordAgaing in
                user.count >= 4 &&
                password.count >= 6 &&
                password == passwordAgaing
            }
            .eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonStatePublisher)
    }
}
