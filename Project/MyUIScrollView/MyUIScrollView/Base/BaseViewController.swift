//
//  BaseViewController.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/18/24.
//

import UIKit

protocol Binderable {
    
}

class BaseViewController: UIViewController, Binderable {
    override func viewDidLoad() {
        initLayout()
    }
    
    private func initLayout() {
        view.backgroundColor = .white
    }
}
