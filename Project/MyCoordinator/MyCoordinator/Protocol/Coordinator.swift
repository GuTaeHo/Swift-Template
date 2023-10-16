//
//  Coordinator.swift
//  MyCoordinator
//
//  Created by 구태호 on 10/16/23.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
