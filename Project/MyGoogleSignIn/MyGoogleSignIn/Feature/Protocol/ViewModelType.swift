//
//  ViewModelType.swift
//  MyGoogleSignIn
//
//  Created by 구태호 on 4/3/24.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
