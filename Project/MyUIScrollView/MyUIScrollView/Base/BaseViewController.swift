//
//  BaseViewController.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/18/24.
//

import UIKit

protocol UICodeBasable {
    func initSubviews()
    func initAttributes()
    func bindViews()
}

protocol UIControllable {
    func initLayout()
    func initAction()
    func bindViews()
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        initLayout()
    }
    
    private func initLayout() {
        view.backgroundColor = .white
    }
}
