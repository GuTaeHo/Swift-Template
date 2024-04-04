//
//  HomeViewModel.swift
//  MyGoogleSignIn
//
//  Created by 구태호 on 4/3/24.
//

import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


final class HomeViewModel: ViewModelType {
    typealias Output = AnyPublisher<Response, Never>
    
    struct Input {
        var googleSignin: AnyPublisher<Int, Never>
    }
    
    private var output: PassthroughSubject<Response, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private weak var presentVC: UIViewController?
    
    struct Response: Error {
        var user: User?
        var errorReason: String?
    }
    
    init(presentVC: UIViewController) {
        self.presentVC = presentVC
    }
    
    func transform(input: HomeViewModel.Input) -> AnyPublisher<Response, Never> {
        input.googleSignin.sink { [weak self] _ in
            self?.googleSignIn()
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    /// 구글 로그인 수행
    func googleSignIn() {
        guard let presentVC else {
            return output.send(.init(errorReason: "표시될 화면을 찾을 수 없습니다."))
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return output.send(.init(errorReason: "구글 ClientID 를 찾을 수 없습니다."))
        }
        
        // 구글 로그인 구성 생성
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // 구글 로그인 시작!
        GIDSignIn.sharedInstance.signIn(withPresenting: presentVC) { [unowned self] result, error in
            guard error == nil else {
                output.send(.init(errorReason: "\(error?.localizedDescription ?? "로그인 중 오류가 발생했습니다.")"))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                output.send(.init(errorReason: "허가 정보를 확인할 수 없습니다."))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if let error {
                    self?.output.send(.init(errorReason: "\(error.localizedDescription)"))
                    return
                }
                // 유저 정보 전송
                self?.output.send(.init(user: result?.user))
            }
        }
    }
    
    /// 구글 로그아웃 수행
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
