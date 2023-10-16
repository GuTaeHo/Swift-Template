//
//  LoginCoordinator.swift
//  MyCoordinator
//
//  Created by 구태호 on 10/16/23.
//

import UIKit

protocol LoginCoordinatorDelegate {
    func didLoggedIn(_ coordinator: LoginCoordinator)
}

/// 로그인 뷰 컨트롤러 생성 및 전환을 담당하는 코디네이터.
class LoginCoordinator: Coordinator, LoginViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: LoginCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController()
        viewController.view.backgroundColor = .brown
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
    func login() {
        self.delegate?.didLoggedIn(self)
    }
}
