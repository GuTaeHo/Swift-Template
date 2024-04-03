//
//  HomeViewModel.swift
//  MyGoogleSignIn
//
//  Created by 구태호 on 4/3/24.
//

import Foundation
import Combine
import FirebaseCore
import GoogleSignIn


final class HomeViewModel: ViewModelType {
    typealias Input = AnyPublisher<Int, Never>
    typealias Output = AnyPublisher<String, Error>
    
    private var output: PassthroughSubject<String, Error> = .init()
    private var cancellables = Set<AnyCancellable>()
    private weak var presentVC: UIViewController?
    
    init(presentVC: UIViewController) {
        self.presentVC = presentVC
    }
    
    func transform(input: AnyPublisher<Int, Never>) -> AnyPublisher<String, Error> {
        // input 구독
        input.sink { [weak self] _ in
            self?.googleSignIn()
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    
    /// 구글 로그인 수행
    private func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return output.send("구글 ClientID 를 찾을 수 없습니다.")
        }
        
        // 구글 로그인 구성 생성
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // 구글 로그인 시작!
        GIDSignIn.sharedInstance.signIn(withPresenting: <#T##UIViewController#>, completion: <#T##((GIDSignInResult?, (any Error)?) -> Void)?##((GIDSignInResult?, (any Error)?) -> Void)?##(GIDSignInResult?, (any Error)?) -> Void#>)
        
        HomeAPI.shared.getWorryDetail(param: worryId) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.output.send(data)
                    self?.worryDetail = data
                } else {
                    self?.output.send(completion: .failure(ErrorCase.appError))
                }
            case .failure(let errorCase):
                self?.output.send(completion: .failure(errorCase))
            }
        }
    }
    
}
